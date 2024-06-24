const debug = require('debug')("app: module-controller-proyects");
const {DataBase}=require('../database');
const {Response}=require('../common/response');

module.exports.ProyectsController = {
    getProyects: async(req, res) => {
        try {
            const result = await DataBase.query("CALL api_inmo_proyects_list()")

            Response.success(res, 200, "Listado de proyectos", result[0][0])
        } catch (error) {
            Response.error(res,error);
            debug(error);
        }
    },
    getProyect: async(req, res) => {
        try {
            const {params: {id}}=req

            const result = await DataBase.query("CALL api_inmo_proyects_get_pry(?)",[id])

            Response.success(res, 200, "Listado de proyectos", result[0][0])
        } catch (error) {
            Response.error(res,error);
            debug(error);
        }
    },
    createProyect: async(req, res) => {
        try {
            const {body: {name_pry}}=req

            await DataBase.query("CALL api_inmo_proyects_ins_upd(?,?,@mensaje)",[0,name_pry])
            const result =  await DataBase.query("SELECT @mensaje AS mensaje")

            Response.success(res, 200, "Proyecto creado", result[0])
        } catch (error) {
            Response.error(res,error);
            debug(error);
        }
    },
    updateProyect: async(req, res) => {
        try {
            const {params: {id}, body: {name_pry}}=req

            await DataBase.query("CALL api_inmo_proyects_ins_upd(?,?,@mensaje)",[id,name_pry])
            const result =  await DataBase.query("SELECT @mensaje AS mensaje")

            Response.success(res, 200, "Proyecto actualizado", result[0])
        } catch (error) {
            
        }
    },
    deleteProyect: async(req, res) => {
        try {
            const {params: {id}}=req

            await DataBase.query("CALL api_inmo_proyects_del(?,@mensaje)",[id])
            const result =  await DataBase.query("SELECT @mensaje AS mensaje")

            Response.success(res, 200, "Proyecto eliminado", result[0])
        } catch (error) {
            
        }
    }
}