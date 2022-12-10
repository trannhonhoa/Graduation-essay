const usersService = require("../services/user.service");
exports.register = (req, res, next) => {
  console.log(req.body);
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
   console.log(req.body);
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
