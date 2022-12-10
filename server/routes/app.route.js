const categoryController = require("../controllers/categories.controller");
const productController = require("../controllers/products.controller");
const userController = require("../controllers/users.controller");
const { uploadCategory, uploadProduct } = require("../middleware/product.upload");
const express = require('express');


const route = express.Router();

// category
route.post('/category', categoryController.create);
route.get('/category', categoryController.findAll);
route.post(
  "/category/single",
  uploadCategory.single("categoryImage"),
  (req, res) => {
    const path = req.file != undefined ? req.file.path.replace(/\\/g, "/") : "";
    if (!path || path === "") {
      const error = new Error("Please upload a file");
      error.httpStatusCode = 400;
      return next(error);
    }

    res.json(path != "" ? "/" + path : "");
  }
);
route.get('/category/:id', categoryController.findOne);
route.put('/category/:id', categoryController.update);
route.delete('/category/:id', categoryController.delete);


// product
route.post('/product', productController.create);
route.get('/product', productController.findAll);
route.post(
  "/product/single",
  uploadProduct.single("productImage"),
  (req, res) => {
    const path = req.file != undefined ? req.file.path.replace(/\\/g, "/") : "";
    if (!path || path === "") {
      const error = new Error("Please upload a file");
      error.httpStatusCode = 400;
      return next(error);
    }

    res.json(path != "" ? "/" + path : "");
  }
);
route.get('/product/:id', productController.findOne);
route.put('/product/:id', productController.update);
route.delete('/product/:id', productController.delete);

// user

route.post('/login', userController.login);
route.post('/register', userController.register);




module.exports = route;