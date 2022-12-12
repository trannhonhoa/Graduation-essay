const slidersService = require("../services/slider.service");

exports.create = (req, res, next) => {
  var model = {
    sliderName: req.body.sliderName,
    sliderDescription: req.body.sliderDescription,
    sliderImage: req.body.sliderImage,
    sliderUrl: req.body.sliderUrl,
  };
  slidersService.createSlider(model, (err, result) => {
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

exports.findAll = (req, res, next) => {
  var model = {
    sliderName: req.body.sliderName,
    pageSize: req.query.pageSize,
    page: req.query.page,
  };
  slidersService.getSliders(model, (err, result) => {
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
    sliderId: req.params.id,
  };
  slidersService.getSliderById(model, (err, result) => {
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
    sliderId: req.params.id,
     sliderName: req.body.sliderName,
     sliderDescription: req.body.sliderDescription,
     sliderImage: req.body.sliderImage,
     sliderUrl: req.body.sliderUrl,
   };
  slidersService.updateSlider(model, (err, result) => {
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
     sliderId: req.params.id,
   };
  slidersService.deleteSlider(model, (err, result) => {
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
