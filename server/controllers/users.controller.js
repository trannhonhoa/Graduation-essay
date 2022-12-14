const usersService = require("../services/user.service");
exports.register = (req, res, next) => {
  usersService.register(req.body, (err, result) => {
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
exports.login = (req, res, next) => {
  const {email, password} = req.body;
  usersService.login({email, password}, (err, result) => {
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
