const express = require("express");
const pool = require("../db");  // Conexión a PostgreSQL desde db.js
const router = express.Router();

// Obtener todos los platos del menú
router.get("/menu", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM menu");
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Agregar un nuevo plato al menú
router.post("/menu", async (req, res) => {
  const { nombre, categoria, precio, disponibilidad, ingredientes } = req.body;
  try {
    const result = await pool.query(
      "INSERT INTO menu (nombre, categoria, precio, disponibilidad, ingredientes) VALUES ($1, $2, $3, $4, $5) RETURNING *",
      [nombre, categoria, precio, disponibilidad, ingredientes]
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
