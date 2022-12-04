const mongoose = require('mongoose');
const product = mongoose.model(
    "Product", mongoose.Schema({
        productName: {
            type: String,
            require: true,
            unique: true
        },
        category: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Category",
        },
        productShortDescription: {
            type: String,
            require: true
        },
        productDescription: {
            type: String,
            require: true
        },
        productPrice: {
            type: Number,
            require: true
        },
        productSalePrice: {
            type: Number,
            require: true,
            default: false
        },
        productImage: {
            type: String

        },
        productSKU: {
            type: String,
            require: true
        },
        productType: {
            type: String,
            require: true,
            default: "simple"
        },
        stockStatus: {
            type: String,
            default: "IN"
        }
    }, {
        toJSON: {
            transform: function(doc, ret) {
                ret.productId = ret._id.toString();
                delete ret._id;
                delete ret._v;
            }
        }
    })
)
module.exports = {
    product
}