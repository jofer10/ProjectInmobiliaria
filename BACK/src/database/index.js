const { createPool } = require("mysql2");
const pool = createPool({
    host: "localhost",
    user: "root",
    password: "",
    database: "pry_inmo",
    port: 3306
});

module.exports.DataBase = pool.promise();