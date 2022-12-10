const {user} = require("../models/user.model");
const bcrypt = require('bcryptjs');
const auth = require('../middleware/auth');
async function login ({email,password}, callback){
    const userModel = await user.findOne({email});
    console.log(userModel);
    if(userModel != null){
        if(bcrypt.compareSync(password, userModel.password)){
            const token = auth.generateToken(userModel.toJSON())
            return callback(null, {...userModel.toJSON(), token})
        }
        else{
            return callback({
                message: "Invalid Email Or Password"
            })
        }
    }
    else{
         return callback({
           message: "Invalid Email Or Password",
         });
    }
}
async function register(params, callback){
    if(params.email === undefined){
        return callback({
            message: "Email required"
        })
    }
    let isUserEx = await user.findOne({email: params.email});
    if(isUserEx){
         return callback({
           message: "Email already register",
         });
    }
    const salt = bcrypt.genSaltSync(10);
    params.password = bcrypt.hashSync(params.password, salt);
    const userChema = new user(params);
    userChema.save()
    .then((res) => callback(null, res))
    .catch((err) => callback(err))
}
module.exports = {
    login, register
}