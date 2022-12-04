const { MONGO_DB_CONFIG } = require('../config/app.config');
const { category } = require('../models/category.model.js');
const { product } = require('../models/product.model.js');
async function createProduct(params, callback) {
    if (!params.productName) {
        return callback({
            message: "Product name required"
        }, "")
    }
    if (!params.category) {
        return callback({
            message: "Category required"
        }, "")
    }
    const model = new product(params);
    model.save()
        .then(res => {
            return callback(null, res)
        })
        .catch(error => {
            return callback(error)
        })
}
async function getProduct(params, callback) {
    const productName = params.productName;
    const categoryId = params.categoryId;
    var condition = {}
    if (productName) {
        condition["productName"] = {
            $regex: new RegExp(productName),
            $options: "i"
        }
    }
    if (categoryId) {
        condition["categoryId"] = categoryId
    }
    let perPage = Math.abs(params.pageSize) || MONGO_DB_CONFIG.PAGE_SIZE;
    let page = (Math.abs(params.page) || 1) - 1;

    product.find(condition, "productId productName productShortDescription productDescription productPrice productSalePrice productImage productSKU productType stockStatus createdAt updatedAt")
        .populate("category", "categoryName categoryImage")
        .sort(params.sort, )
        .limit(perPage)
        .skip(perPage * page)
        .then(res => {
            return callback(null, res)
        })
        .catch(error => {
            return callback(error)
        })
}
async function getProductById(params, callback) {
    const productId = params.productId;

    product.findById(productId)
        .populate("category", "categoryName categoryImage")
        .then(res => {
            if (!res) callback("Not found product with Id" + productId)
            return callback(null, res)
        })
        .catch(error => {
            return callback(error)
        })
}

async function updateProduct(params, callback) {
    const productId = params.productId;


    product.findByIdAndUpdate(productId, params, { useFindAndModify: false })
        .then(res => {
            if (!res) callback("Not found product with Id" + productId)
            return callback(null, res)
        })
        .catch(error => {
            return callback(error)
        })
}
async function deleteProduct(params, callback) {
    const productId = params.productId;


    product.findByIdAndDelete(productId)
        .then(res => {
            if (!res) callback("Not found product with Id" + productId)
            return callback(null, res)
        })
        .catch(error => {
            return callback(error)
        })
}
module.exports = {
    createProduct,
    getProduct,
    getProductById,
    updateProduct,
    deleteProduct
}