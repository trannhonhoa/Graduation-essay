const categoriesService = require("../services/category.service");
const asyncHandler = require("express-async-handler");
exports.create = (req, res, next) => {
  const { categoryName, categoryDescription, categoryImage } = req.body;
  var model = {
    categoryName,
    categoryDescription,
    categoryImage,
  };

  categoriesService.createCategory(model, (err, result) => {
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
  var model = {
    categoryName: req.body.categoryName,
    pageSize: req.query.pageSize,
    page: req.query.page,
  };
  categoriesService.getCategories(model, (err, result) => {
    if (err) {
      return next(err);
    } else {
      console.log(result)
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

exports.update = (req, res, next) => {
  var model = {
    categoryId: req.params.id,
    categoryName: req.body.categoryName,
    categoryDescription: req.body.categoryDescription,
    categoryImage: req.body.categoryImage,
  };
  categoriesService.updateCategory(model, (err, result) => {
    if (err) {
      return next(error);
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
    categoryId: req.params.id,
  };
  categoriesService.deleteCategory(model, (err, result) => {
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
