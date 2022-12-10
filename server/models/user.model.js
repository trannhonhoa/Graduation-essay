const mongoose = require("mongoose");
const user = mongoose.model(
  "User",
  mongoose.Schema(
    {
      fullName: {
        type: String,
        require: true,
      },
      email: {
        type: String,
        unique: true,
        require: true,
      },
      password: {
        type: String,
        require: true
      },
    },
    {
      toJSON: {
        transform: function (doc, ret) {
          ret.userId = ret._id.toString();
          delete ret._id;
          delete ret._v;
          delete ret.password;
        },
      },
    
    },
    {
        timestamps: true
    }
  )
);
module.exports = {
  user,
};
