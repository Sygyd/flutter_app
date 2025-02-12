const express = require("express");
const router = express.Router();
const { createUser } = require("../models/userModel");

router.post("/register", async (req, res) => {
  console.log("Datos recibidos del frontend:", req.body);
  try {
    const { nombre, apellido, cedula, email } = req.body;
    const newUser = await createUser(nombre, apellido, cedula, email);
    res.status(201).json(newUser);
  } catch (error) {
    res.status(500).json({ error: "Error al registrar el usuario" });
  }
});

module.exports = router;