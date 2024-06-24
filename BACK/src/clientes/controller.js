const debug = require("debug")("app: module-controller-clientes");
const { DataBase } = require("../database");
const { Response } = require("../common/response");

module.exports.ClientesController = {
  getClientes: async (req, res) => {
    try {
      const result = await DataBase.query(
        "CALL api_inmo_clientes_list()"
      );
      Response.success(res, 200, "Listado de clientes", result[0][0]);//para mostrar el lsitado de clientes
    } catch (error) {
        Response.error(res,error);
        debug(error);
    }
  },
  getCliente: async(req, res) =>{
    try {
        const {params: {id}}=req
        
        const result = await DataBase.query("CALL api_inmo_clientes_get_client(?)",[id])

        Response.success(res, 200, "Listado de clientes", result[0][0]);//para mostrar el lsitado de clientes
    } catch (error) {
        Response.error(res,error);
        debug(error);
    }
  },
  createClient: async (req, res) => {
    try {
        const {body: {nombres, email}}=req
        await DataBase.query("CALL api_inmo_clientes_ins_upd(?,?,?,@mensaje)",[0,nombres,email])
        const result= await DataBase.query('SELECT @mensaje AS mensaje')
        
        Response.success(res, 200, "Cliente insertado", result[0]) //devolverá un mensaje
    } catch (error) {
        Response.error(res,error);
        debug(error);
    }
  },
  updateClient: async(req, res) => {
    try {
        const {params: {id}}=req
        const {body: {nombres, email}}=req

        await DataBase.query("CALL api_inmo_clientes_ins_upd(?,?,?,@mensaje)",[id,nombres,email])
        const result= await DataBase.query('SELECT @mensaje AS mensaje')

        Response.success(res, 200, "Cliente actualizado", result[0]) //devolverá un mensaje
    } catch (error) {
        Response.error(res,error);
        debug(error);
    }
  },
  deleteClient: async(req, res) => {
    try {
        const {params: {id}}=req

        await DataBase.query("CALL api_inmo_clientes_del(?,@mensaje)",[id])
        const result= await DataBase.query('SELECT @mensaje AS mensaje')

        Response.success(res, 200, "Cliente actualizado", result[0]) //devolverá un mensaje
    } catch (error) {
        Response.error(res,error);
        debug(error);
    }
  }
};
