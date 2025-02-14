const express = require("express");
const router = express.Router();
const { createUser, getAllUsers, getUserById, updateUser, deleteUser } = require("../models/userModel");

// 🔹 Registrar un usuario (POST)
router.post("/register", async (req, res) => {
  console.log("Datos recibidos del frontend:", req.body);
  try {
    const { nombre, apellido, cedula, email, contrasena } = req.body;

    // Llamada a la función createUser
    const newUser = await createUser(nombre, apellido, cedula, email, contrasena);
    res.status(201).json(newUser); // Registro exitoso
  } catch (error) {
    console.error("Error al registrar el usuario:", error);
    res.status(500).json({ error: "Error al registrar el usuario" });
  }
});


// 🔹 Obtener todos los usuarios (GET)
router.get("/users", async (req, res) => {
  try {
    const users = await getAllUsers();
    res.json(users);
  } catch (error) {
    console.error("Error al obtener los usuarios:", error);
    res.status(500).json({ error: "Error al obtener los usuarios" });
  }
});

// 🔹 Obtener un usuario por ID (GET)
router.get("/users/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const user = await getUserById(id);
    if (user) {
      res.json(user);
    } else {
      res.status(404).json({ error: "Usuario no encontrado" });
    }
  } catch (error) {
    console.error("Error al obtener el usuario:", error);
    res.status(500).json({ error: "Error al obtener el usuario" });
  }
});

// 🔹 Actualizar un usuario por ID (PUT)
router.put("/users/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const { nombre, apellido, cedula, email } = req.body;
    const updatedUser = await updateUser(id, nombre, apellido, cedula, email);
    if (updatedUser) {
      res.json(updatedUser);
    } else {
      res.status(404).json({ error: "Usuario no encontrado" });
    }
  } catch (error) {
    console.error("Error al actualizar el usuario:", error);
    res.status(500).json({ error: "Error al actualizar el usuario" });
  }
});

// 🔹 Eliminar un usuario por ID (DELETE)
router.delete("/users/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const success = await deleteUser(id);
    if (success) {
      res.json({ message: "Usuario eliminado correctamente" });
    } else {
      res.status(404).json({ error: "Usuario no encontrado" });
    }
  } catch (error) {
    console.error("Error al eliminar el usuario:", error);
    res.status(500).json({ error: "Error al eliminar el usuario" });
  }
});

module.exports = router;
