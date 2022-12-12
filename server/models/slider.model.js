const mongoose = require("mongoose");
const slider = mongoose.model(
  "Slider",
  mongoose.Schema(
    {
      sliderName: {
        type: String,
        require: true,
        unique: true,
      },
      sliderDescription: {
        type: String,
        require: false,
      },
      sliderUrl: {
        type: String,
      },
      sliderImage: {
        type: String,
        require: true
      },
    },
    {
      toJSON: {
        transform: function (doc, ret) {
          ret.sliderId = ret._id.toString();
          delete ret._id;
          delete ret._v;
        },
      },
    }
  )
);
module.exports = {
  slider,
};
