const jwt = require("jsonwebtoken");
const { supabase } = require("../utils/supabaseClient");

// Verificar JWT token
const protect = async (req, res, next) => {
  let token;
  if (req.headers.authorization && req.headers.authorization.startsWith("Bearer")) {
    try {
      token = req.headers.authorization.split(" ")[1];
      const decoded = jwt.verify(token, process.env.JWT_SECRET);
      // Verificar con Supabase
      const { data: { user }, error } = await supabase.auth.getUser(token);
      if (error || !user) return res.status(401).json({ message: "Token inválido" });
      req.user = user;
      next();
    } catch (error) {
      res.status(401).json({ message: "Token inválido" });
    }
  }
  if (!token) res.status(401).json({ message: "Sin autorización" });
};

// Middleware: rol ENTRENADOR
const entrenador = (req, res, next) => {
  if (req.user.user_metadata?.role === "ENTRENADOR") {
    next();
  } else {
    res.status(403).json({ message: "Acceso restringido a entrenadores" });
  }
};

module.exports = { protect, entrenador };
