module.exports.Response = {
  success: (res, status = 200, message = "ok", body = {}) => {
    res.status(status).json({ message, body});
  },
  error: (res, error = null) => {
    const statusCode = error && error.statusCode ? error.statusCode : 500;
    const message = error && error.message ? error.message : "Ha ocurrido un error desconocido";
    res.status(statusCode).json({ message });
  },
};