const pool = require("../servidor.js");

const createUser = async (nombre, apellido, cedula, email) => {
  const result = await pool.query(
    "INSERT INTO personas (nombre, apellido, cedula, email) VALUES ($1, $2, $3, $4) RETURNING *",
    [nombre, apellido, cedula, email]
  );
  return result.rows[0];
};

module.exports = { createUser };