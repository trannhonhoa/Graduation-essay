const { relatedProduct } = require("../models/related-product.model");
const { product } = require("../models/product.model");
async function addRelatedProduct(params, callback) {
  if (!params.product) {
    return callback(
      {
        message: "Product ID Required",
      },
      ""
    );
  }
  if (!params.relatedProduct) {
    return callback(
      {
        message: "Related Product ID Required",
      },
      ""
    );
  }
  const model = new relatedProduct(params);
  model
    .save()
    .then(async (res) => {
        await product.findByIdAndUpdate(
          {
            _id: params.product,
          },
          {
            $addToSet: {
              relatedProducts: model,
            },
          }
        );
      return callback(null, res);
    })
    .catch((error) => {
      return callback(error);
    });
}


async function removeRelatedProduct(params, callback) {
    const id = params.id;
    relatedProduct.findByIdAndRemove(id)
    .then((res) => {
        if(!res){
            callback("Product Id not found")
        }
        else{
            callback(null, res)
        }
    })
    .catch((error) => {
        return callback(error, )
    })
}
module.exports = {
  addRelatedProduct,
  removeRelatedProduct,
};
