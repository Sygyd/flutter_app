const bcrypt = require("bcrypt");
const pool = require("../db");  // Aquí importamos el pool desde el archivo db.js

// 🔹 Crear un nuevo usuario
const createUser = async (nombre, apellido, cedula, email, contrasena) => {
  try {
    // Insertar en la tabla 'personas'
    const { rows: personas } = await pool.query(
      "INSERT INTO personas (nombre, apellido, cedula, email) VALUES ($1, $2, $3, $4) RETURNING idpersonas",
      [nombre, apellido, cedula, email]
    );

    const idpersonas = personas[0].idpersonas;

    // Insertar en la tabla 'usuario' usando el idpersonas
    const { rows } = await pool.query(
      "INSERT INTO usuario (idpersona, contrasena, rol) VALUES ($1, $2, $3) RETURNING *",
      [idpersonas, contrasena, 1] // El rol predeterminado es 1 (Cliente)
    );

    return rows[0];
  } catch (error) {
    console.error("Error al crear el usuario:", error);
    throw error;
  }
};


// 🔹 Obtener todos los usuarios
const getAllUsers = async () => {
  try {
    const { rows } = await pool.query("SELECT * FROM personas");
    return rows;
  } catch (error) {
    console.error("Error al obtener los usuarios:", error);
    throw error;
  }
};

// 🔹 Obtener un usuario por ID
const getUserById = async (id) => {
  try {
    const { rows } = await pool.query("SELECT * FROM personas WHERE idpersonas = $1", [id]);
    return rows[0];
  } catch (error) {
    console.error("Error al obtener el usuario:", error);
    throw error;
  }
};

// 🔹 Actualizar un usuario por ID
const updateUser = async (id, nombre, apellido, cedula, email) => {
  try {
    const { rows } = await pool.query(
      "UPDATE personas SET nombre = $1, apellido = $2, cedula = $3, email = $4 WHERE idpersonas = $5 RETURNING *",
      [nombre, apellido, cedula, email, id]
    );
    return rows[0];
  } catch (error) {
    console.error("Error al actualizar el usuario:", error);
    throw error;
  }
};

// 🔹 Eliminar un usuario por ID
const deleteUser = async (id) => {
  try {
    const { rowCount } = await pool.query("DELETE FROM personas WHERE idpersonas = $1", [id]);
    return rowCount > 0;
  } catch (error) {
    console.error("Error al eliminar el usuario:", error);
    throw error;
  }
};

module.exports = { createUser, getAllUsers, getUserById, updateUser, deleteUser };
