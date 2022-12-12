const relatedProductService = require("../services/related-product.service");

exports.create = (req, res, next) => {
  
  relatedProductService.addRelatedProduct(req.body, (err, result) => {
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
  var model = {
    id: req.params.id,
  };
  relatedProductService.removeRelatedProduct(model, (err, result) => {
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
