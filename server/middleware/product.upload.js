const multer = require('multer');
const Path = require('path');
const storgeProduct = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, "./uploads/products")
    },
    filename: (req, file, cb) => {
        cb(null, Date.now() + "-" + file.originalname);
    }
})
const storgeCategory = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./uploads/categories");
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + "-" + file.originalname);
  },
});
const storgeSlider = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./uploads/sliders");
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + "-" + file.originalname);
  },
});
const fileFilter = (req, file, cb) => {
    const acceptableExt = [".png", ".jpg", ".jpeg", ".gif"];
    if (!acceptableExt.includes(Path.extname(file.originalname))) {
        return cb(new Error("Only .png, .jpg, .gif and .jpeg format allowed!"));

    }
    const fileSize = parseInt(req.headers['content-length']);
    if (fileSize > 1048576) {
        return cb(new Error("File Size Big"));
    }
    cb(null, true)
}
let uploadProduct = multer({
  storage: storgeProduct,
  fileFilter: fileFilter,
  fileSize: 1048576,
});
let uploadCategory = multer({
  storage: storgeCategory,
  fileFilter: fileFilter,
  fileSize: 1048576,
});
let uploadSlider = multer({
  storage: storgeSlider,
  fileFilter: fileFilter,
  fileSize: 1048576,
});
module.exports = { uploadProduct, uploadCategory, uploadSlider };