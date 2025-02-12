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
  user: 'rasa',
  host: 'localhost',
  database: 'postgres',
  password: 'monito',
  port: 5432,
});



app.listen(3000, () => {
  console.log('Servidor corriendo en http://localhost:3000');
});