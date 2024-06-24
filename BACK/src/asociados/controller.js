const debug = require("debug")("app: module-controller-asociados");
const { DataBase } = require("../database");
const { Response } = require("../common/response");

module.exports.AsociadosController= {
    getAsociados: async(req, res)=>{
        try {
            const {body: {name_pry,fec_ini,fec_fin}}=req
            
            const result = await DataBase.query("CALL api_inmo_as_pry_list(?,?,?)", [name_pry,fec_ini,fec_fin])
            
            Response.success(res, 200, "Listado de asociados proyectos", result[0][0])
        } catch (error) {
            Response.error(res,error);
            debug(error);
        }
    },
    getAsociado: async(req, res)=>{
        try {
            const {params: {id}}=req

            const result = await DataBase.query("CALL api_inmo_as_pry_detail_list(?)", [id])

            Response.success(res, 200, "Listado detalle asociados", result[0][0])
        } catch (error) {
            Response.error(res,error);
            debug(error);
        }
    },
    createAsociados: async(req, res)=>{
        try {
            const {body: {id_cliente, id_proyecto, fecha}}=req
            await DataBase.query("CALL api_inmo_as_pry_ins(?,?,?,@mensaje)", [id_cliente, id_proyecto, fecha])
            const result =  await DataBase.query("SELECT @mensaje AS mensaje")

            Response.success(res, 200, "Asociado creado", result[0])
        } catch (error) {
            Response.error(res,error);
            debug(error);
        }
    },
    createDetailAsociado: async(req, res)=>{
        try {
            const {body: {id_as_pry, fec_pago, monto_cuota}}=req
            await DataBase.query("CALL api_inmo_as_pry_detail_ins_upd(?,?,?,?,@mensaje)", [0,id_as_pry, fec_pago, monto_cuota])
            const result =  await DataBase.query("SELECT @mensaje AS mensaje")

            Response.success(res, 200, "Detalle asociado creado", result[0])
        } catch (error) {
            Response.error(res,error);
            debug(error);
        }
    }
}