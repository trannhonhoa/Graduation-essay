const { MONGO_DB_CONFIG } = require('../config/app.config');
const { slider } = require('../models/slider.model.js');

async function createSlider(params, callback) {
    if (!params.sliderName) {
        return callback({
            message: "Slider Name Required"
        }, "")
    }
    const model = new slider(params);
    model.save()
        .then(res => {
            return callback(null, res)
        })
        .catch(error => {
            return callback(error)
        })
}
async function getSliders(params, callback) {
    const sliderName = params.sliderName;
    var condition = sliderName ? {
        sliderName: {
            $regex: new RegExp(sliderName),
            $options: "i"
        }
    } : {}
    let perPage = Math.abs(params.pageSize) || MONGO_DB_CONFIG.PAGE_SIZE;
    let page = (Math.abs(params.page) || 1) - 1;

    slider.find(condition, "sliderName sliderImage sliderDescription sliderUrl")
        .limit(perPage)
        .skip(perPage * page)
        .then(res => {
            return callback(null, res)
        })
        .catch(error => {
            return callback(error)
        })
}
async function getSliderById(params, callback) {
    const sliderId = params.sliderId;
    slider.findById(sliderId)
        .then(res => {
            if (!res) callback("Not found slider with Id" + sliderId)
            return callback(null, res)
        })
        .catch(error => {
            return callback(error)
        })
}

async function updateSlider(params, callback) {
    const sliderId = params.sliderId;


    slider.findByIdAndUpdate(sliderId, params, { useFindAndModify: false })
        .then(res => {
            if (!res) callback("Not found slider with Id" + sliderId)
            return callback(null, res)
        })
        .catch(error => {
            return callback(error)
        })
}
async function deleteSlider(params, callback) {
    const sliderId = params.sliderId;


    slider.findByIdAndDelete(sliderId)
        .then(res => {
            if (!res) callback("Not found slider with Id" + sliderId)
            return callback(null, res)
        })
        .catch(error => {
            return callback(error)
        })
}
module.exports = {
    createSlider,
    getSliders,
    getSliderById,
    updateSlider,
    deleteSlider
}