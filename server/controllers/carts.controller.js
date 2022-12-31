const cartsService = require("../services/cart.service");

exports.create = (req, res, next) => {
  const { 
    userId,
    products
   } = req.body;
  var model = {
    userId,
    products,
  };

  cartsService.addCart(model, (err, result) => {
    if (err) {
      return next(err)
    } else {
      return res.status(200).send({
        message: "Sucess",
        data: result,
      });
    }
  });
};

exports.findAll = (req, res, next) => {
  cartsService.getCart({userId: req.user.userId}, (err, result) => {
    if (err) {
      return next(err);
    } else {
      return res.status(200).send({
        message: "Sucess",
        data: result,
      });
    }
  });
};
exports.findOne = (req, res, next) => {
  var model = {
    categoryId: req.params.id,
  };
  categoriesService.getCategoryById(model, (err, result) => {
    if (err) {
      return next(err);
    } else {
      return res.status(200).send({
        message: "Sucess",
        data: result,
      });
    }
  });
};


exports.delete = (req, res, next) => {
  const { userId, products, qty } = req.body;
  var model = {
    userId,
    products,
    qty,
  };
  cartsService.removeItemIndex(model, (err, result) => {
    if (err) {
      return next(err);
    } else {
      return res.status(200).send({
        message: "Sucess",
        data: result,
      });
    }
  });
};
