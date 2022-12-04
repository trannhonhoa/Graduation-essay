const express = require("express")
const { append } = require("express/lib/response")

const MONGO_DB_CONFIG = {
    DB: "mongodb://localhost/ecommerce-app-demo",
    PAGE_SIZE: 10,
}
module.exports = {
    MONGO_DB_CONFIG
}