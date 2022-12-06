const productsService = require('../services/product.service');


exports.create = (req, res, next) => {
    var model = {
        productName: req.body.productName,
        category: req.body.category,
        productShortDescription: req.body.productShortDescription,
        productDescription: req.body.productDescription,
        productPrice: req.body.productPrice,
        productSalePrice: req.body.productSalePrice,
        productSKU: req.body.productSKU,
        productType: req.body.productType,
        stockStatus: req.body.stockStatus,
        productImage: req.body.productImage
    }
    productsService.createProduct(model, (err, result) => {
        if (err) {
            return next(err);
        } else {
            return res.status(200).send({
                message: "Sucess",
                data: result
            })
        }
    })
}

exports.findAll = (req, res, next) => {
    var model = {
        categoryName: req.query.categoryName,
        categoryId: req.query.categoryId,
        pageSize: req.query.pageSize,
        page: req.query.page,
        sort: req.query.sort
    }
    productsService.getProduct(model, (err, result) => {
        if (err) {
            return next(err);
        } else {
            return res.status(200).send({
                message: "Sucess",
                data: result
            })
        }
    })
}
exports.findOne = (req, res, next) => {
    var model = {
        productId: req.params.id,
    }
    productsService.getProductById(model, (err, result) => {
        if (err) {
            return next(err);
        } else {
            return res.status(200).send({
                message: "Sucess",
                data: result
            })
        }
    })
}

exports.update = (req, res, next) => {
    var model = {
        productId: req.body.productId,
        productName: req.body.productName,
        category: req.body.category,
        productShortDescription: req.body.productShortDescription,
        productDescription: req.body.productDescription,
        productPrice: req.body.productPrice,
        productSalePrice: req.body.productSalePrice,
        productSKU: req.body.productSKU,
        productType: req.body.productType,
        stockStatus: req.body.stockStatus,
        productImage: req.body.productImage,
    };
    productsService.updateProduct(model, (err, result) => {
        if (err) {
            return next(err);
        } else {
            return res.status(200).send({
                message: "Sucess",
                data: result
            })
        }
    })
}

exports.delete = (req, res, next) => {
    var model = {
        productId: req.params.id,

    }
    productsService.deleteProduct(model, (err, result) => {
        if (err) {
            return next(err);
        } else {
            return res.status(200).send({
                message: "Sucess",
                data: result
            })
        }
    })
}