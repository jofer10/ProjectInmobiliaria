const express = require("express");
const router = express.Router();
const { ClientesController } = require("./controller");

module.exports.ClienteAPI = (app) => {
  router
  .get("/", ClientesController.getClientes)
  .get("/:id", ClientesController.getCliente)
  .post("/", ClientesController.createClient)
  .put("/:id", ClientesController.updateClient)
  .delete("/:id",ClientesController.deleteClient)

  app.use("/api/clientes", router);
};
