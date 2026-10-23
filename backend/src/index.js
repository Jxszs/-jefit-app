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

// Health
app.get("/api/health", (req, res) => res.json({ status: "ok", supabase: !!supabase }));

// Routes
app.use("/api/auth", require("./routes/authRoutes"));
app.use("/api/tracking", require("./routes/trainingRoutes"));
app.use("/api/checkin", require("./routes/checkinRoutes"));
app.use("/api/ejercicios", require("./routes/exerciseRoutes"));

app.listen(PORT, () => console.log("JEFIT RPC server corriendo en puerto " + PORT));
