const express = require("express");
const router = express.Router();
const { ProyectsController } = require("./controller");

module.exports.ProyectoAPI = (app) => {
  router
    .get("/", ProyectsController.getProyects)
    .get("/:id", ProyectsController.getProyect)
    .post("/", ProyectsController.createProyect)
    .put("/:id", ProyectsController.updateProyect)
    .delete("/:id", ProyectsController.deleteProyect);

  app.use("/api/proyectos", router);
};
