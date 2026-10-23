require("dotenv").config();
const express = require("express");
const cors = require("cors");
const { createClient } = require("@supabase/supabase-js");

const app = express();
const PORT = process.env.PORT || 5000;

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

app.use(cors());
app.use(express.json());

app.get("/api/health", (req, res) => {
  res.json({ status: "ok", supabase: !!supabase });
});

app.post("/api/ranks/calculate/:userId", async (req, res) => {
  try {
    const userId = req.params.userId;
    const { data, error } = await supabase.rpc("calculate_user_ranks", {
      target_user_id: userId
    });
    if (error) return res.status(400).json({ error: error.message });
    res.json({ data });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.listen(PORT, () => {
  console.log("JEFIT RPC server corriendo en puerto " + PORT);
});
