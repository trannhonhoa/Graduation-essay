const express = require('express');
const app = express();
const mongoose = require('mongoose');
const { MONGO_DB_CONFIG } = require('./config/app.config');
const errors = require('./middleware/errors');
var cors = require('cors');
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
mongoose.Promise = global.Promise;
mongoose.connect(MONGO_DB_CONFIG.DB, {
        useNewUrlParser: true,
        useUnifiedTopology: true
    })
    .then(() => {
        console.log('Database connected');
    })
    .catch((error) => {
        console.log("DB error: " + error)
    })
app.use("/uploads", express.static("uploads"));
app.use("/api", require('./routes/app.route'));
app.use(errors.handlerError);
app.listen(process.env.port || 5000, "172.18.128.1", function () {
  console.log("Ready to Go !");
});