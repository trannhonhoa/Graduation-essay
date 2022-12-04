const multer = require('multer');
const Path = require('path');
const storge = multer.diskStorage({

    destination: (req, file, cb) => {
        cb(null, "./uploads/categories")
    },
    filename: (req, file, cb) => {
        cb(null, Date.now() + "-" + file.originalname);
    }
})
const fileFilter = (req, file, cb) => {
    const acceptableExt = [".png", ".jpg", ".jpeg"];
    if (!acceptableExt.includes(Path.extname(file.originalname))) {
        return cb(new Error("Only .png, .jpg and .jpeg format allowed!"));

    }
    const fileSize = parseInt(req.headers['content-length']);
    if (fileSize > 1048576) {
        return cb(new Error("File Size Big"));
    }
    cb(null, true)
}
let upload = multer({
    storage: storge,
    fileFilter: fileFilter,
    fileSize: 1048576
})
module.exports = upload.single('categoryImage')