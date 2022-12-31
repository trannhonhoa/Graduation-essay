const { response } = require('express');
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
      
        condition["category"] = categoryId;
    }
    
    if(params.productIds){
        condition["_id"] = {
            $in: params.productIds.split(",")
        }
    }
    let perPage = Math.abs(params.pageSize) || MONGO_DB_CONFIG.PAGE_SIZE;
    let page = (Math.abs(params.page) || 1) - 1;

    product.find(condition, "productId productName productShortDescription productDescription productPrice productSalePrice productImage productSKU productType stockStatus createdAt updatedAt")
        .populate("category", "categoryName categoryImage")
        .populate("relatedProducts", "relatedProduct")
        .sort(params.sort)
        .limit(perPage)
        .skip(perPage * page)
        .then(response => {
            var res = response.map(r => {
                if(r.relatedProducts.length > 0){
                    r.relatedProducts = r.relatedProducts.map((x)=> x.relatedProduct)
                }
                return r;
            })
            return callback(null, res)
        })
        .catch(error => {
            return callback(error)
        })
}
async function getProductById(params, callback) {
    const productId = params.productId;

    product
      .findById(productId)
      .populate("category", "categoryName categoryImage")
      .populate("relatedProducts", "relatedProduct")
      .then((response) => {
        if (!response) callback("Not found product with Id" + productId);
        response.relatedProducts = response.relatedProducts.map(
          (x) => x.relatedProduct
        );
        return callback(null, response);
      })
      .catch((error) => {
        return callback(error);
      });
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