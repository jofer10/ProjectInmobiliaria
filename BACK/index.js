const express = require("express");
const app = express();
const cors = require("cors");
const debug = require("debug")("app: module-main");
const { Config } = require("./src/config");
const {ClienteAPI}=require('./src/clientes');
const {ProyectoAPI}=require('./src/proyectos');
const {AsociadosAPI}=require('./src/asociados');
const {IndexAPI,NotFoundAPI}=require('./src/validation');

// Admisión de datos JSON y comunicación de puertos
app.use(express.json());
app.use(cors());

IndexAPI(app)
ClienteAPI(app)
ProyectoAPI(app)
AsociadosAPI(app)
NotFoundAPI(app)

// Levantamos el servidor
app.listen(Config.port, () => {
    debug(`Servidor escuchando en http://localhost:${Config.port}`);
});
