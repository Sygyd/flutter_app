require('dotenv').config();
const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');
const userRoutes = require("./route/userRoute");
const bodyParser = require("body-parser");

const app = express();
app.use(cors());
app.use(express.json());
app.use(bodyParser.json());
app.use(userRoutes);

const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'postgres',
  password: 'monito',
  port: 5432,
});

pool.connect()
  .then(() => console.log("Conectado a PostgreSQL"))
  .catch(err => console.error("Error de conexión a PostgreSQL:", err));

module.exports = pool;

(async () => {
  try {
    const result = await pool.query("SELECT NOW()");
    console.log("Conexión a PostgreSQL funcionando:", result.rows[0]);
  } catch (error) {
    console.error("Error en la conexión a PostgreSQL:", error);
  }
})();


app.listen(3000, () => {
  console.log('Servidor corriendo en http://localhost:3000');
});