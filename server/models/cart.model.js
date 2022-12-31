const mongoose = require("mongoose");
const cart = mongoose.model(
  "Cart",
  mongoose.Schema(
    {
      userId: {
        type: String,
        require: true,
      },
      products: [
        {
            product:{
                type: mongoose.Schema.Types.ObjectId,
                ref: "product",
                require: true
            },
            qty:{
                type: Number,
                require:true
            }
        }
      ]
    },
    {
      toJSON: {
        transform: function (doc, ret) {
          ret.cartId = ret._id.toString();
          delete ret._id;
          delete ret._v;
        },
      },
    },{
        timestamps: true
    }
  )
);
module.exports = {
  cart,
};
