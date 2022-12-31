const { cart } = require("../models/cart.model.js");
const async = require("async");
async function addCart(params, callback) {
  if (!params.userId) {
    return callback({
      message: "UserId Required",
    });
  }
  cart.findOne(
    {
      userId: params.userId,
    },
    function (error, cartDB) {
      if (error) {
        callback(error);
      } else {
        if (cartDB == null) {
          const cartModel = new cart({
            userId: params.userId,
            products: params.products,
          });
          cartModel
            .save()
            .then((res) => {
              return callback(null, res);
            })
            .catch((err) => {
              return callback(err);
            });
        } else if (cartDB.product.length == 0) {
          cartDB.products = params.products;
          cartDB.save();
          return callback(null, cartDB);
        } else {
          async.eachSeries(params.products, function (product, asyncDone) {
            let itemIndex = cartDB.products.findIndex(
              (p) => p.product == product.product
            );
            if (itemIndex === -1) {
              cartDB.products.push({
                product: product.product,
                qty: product.qty,
              });
              cartDB.save(asyncDone);
            } else {
              cartDB.products[itemIndex].qty += product.qty;
              cartDB.save(asyncDone);
            }
          });
          return callback(null, cartDB);
        }
      }
    }
  );
}
async function getCart(params, callback) {
  cart
    .findOne({ userId: params.userId })
    .populate({
      path: "product",
      populate: {
        path: "product",
        model: "Product",
        select: "productName productPrice productSalePrice productImage",
        populate: {
          path: "category",
          model: "Category",
          select: "categoryName",
        },
      },
    })
    .then((res) => {
      return callback(null, res);
    })
    .catch((error) => {
      return callback(error);
    });
}
async function removeItemIndex(params, callback) {
  cart.findOne({ userId: params.userId }, function (err, cartDB) {
    if (err) callback(err);
    else {
      if (params.productId && params.qty) {
        const productId = params.productId;
        const qty = params.qty;
        if (cartDB.products.length === 0) {
          return callback(null, "CartEmpty");
        } else {
          let itemIndex = cartDB.products.findIndex(
            (p) => p.product == productId
          )
          if(itemIndex == -1){
            return callback(null, "Invaliad Product")
          }
          else{
            if(cartDB.products[itemIndex].qty === qty){
                cartDB.products.splice(itemIndex, 1)
            }
            else if(cartDB.products[itemIndex].qty > qty){
                cartDB.products[itemIndex].qty = cartDB.products[itemIndex].qty - qty;
            }
            else{
                return callback(null, "Enter lower Qty")
            }
            cartDB.save((err, cartM) =>{
                if(err) return callback(err)
                return callback(null, "Cart updated")
            })
          }
        }
      }
    }
  });
}


module.exports = {
  addCart, getCart, removeItemIndex
};
