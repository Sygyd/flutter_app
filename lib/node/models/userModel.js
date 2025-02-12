const pool = require("../servidor");

const createUser = async (nombre, apellido, cedula, email) => {
  try {
    const result = await pool.query(
      "INSERT INTO personas (nombre, apellido, cedula, email) VALUES ($1, $2, $3, $4) RETURNING *",
      [nombre, apellido, cedula, email]
    );
    return result.rows[0];
  } catch(error){
    console.error("Error en la consulta SQL:", error);
    throw error;
  }
};

/*(async () => {
  try {
    const result = await pool.query("SELECT NOW()");
    console.log("Conexión a PostgreSQL funcionando:", result.rows[0]);
  } catch (error) {
    console.error("Error en la conexión a PostgreSQL:", error);
  }
})();*/


module.exports = { createUser };