// validation/authValidation.js
const Joi = require('joi')

const signupSchema = Joi.object({
  username: Joi.string().min(1).max(100).required(),
  email: Joi.string().email().required(),
  password: Joi.string().min(6).required()
})

const loginSchema = Joi.object({
  email: Joi.string().email().required(),
  password: Joi.string().required()
})

module.exports = {
  signupSchema,
  loginSchema
}