// validation/eventValidation.js
const Joi = require('joi')

const eventCreateSchema = Joi.object({
  title: Joi.string().max(255).required(),
  description: Joi.string().allow('', null),
  event_date: Joi.date().iso().required(),
  location: Joi.string().max(255).allow('', null)
})

const rsvpSchema = Joi.object({
  status: Joi.string().valid('going', 'maybe', 'invited', 'declined').required()
})

module.exports = {
  eventCreateSchema,
  rsvpSchema
}