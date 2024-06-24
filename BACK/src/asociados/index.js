const express = require("express");
const router = express.Router();
const { AsociadosController } = require("./controller");

module.exports.AsociadosAPI=(app)=>{
    router
    .get("/:id", AsociadosController.getAsociado)
    .post("/", AsociadosController.getAsociados)
    .post("/create/", AsociadosController.createAsociados)
    .post("/createDetail/", AsociadosController.createDetailAsociado)

    app.use("/api/asociados", router)
}