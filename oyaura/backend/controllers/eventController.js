// controllers/eventController.js
const eventService = require('../services/eventService')
const { eventCreateSchema, rsvpSchema } = require('../validation/eventValidation')

async function createEvent(req, res) {
  try {
    const { error, value } = eventCreateSchema.validate(req.body)
    if (error) return res.status(400).json({ error: error.details[0].message })

    const organizer_id = req.user.user_id
    const event = await eventService.createEvent(organizer_id, value)

    res.status(201).json({ event })
  } catch (err) {
    console.error('Create event error', err)
    res.status(500).json({ error: 'Internal server error' })
  }
}

async function getAllEvents(req, res) {
  try {
    const events = await eventService.getAllEvents()
    res.json({ events })
  } catch (err) {
    console.error('Fetch events error', err)
    res.status(500).json({ error: 'Internal server error' })
  }
}

async function getMyEvents(req, res) {
  try {
    const user_id = req.user.user_id
    const events = await eventService.getMyEvents(user_id)
    res.json({ events })
  } catch (err) {
    console.error('Fetch my-events error', err)
    res.status(500).json({ error: 'Internal server error' })
  }
}

async function rsvp(req, res) {
  try {
    const { error, value } = rsvpSchema.validate(req.body)
    if (error) return res.status(400).json({ error: error.details[0].message })

    const event_id = req.params.id
    const user_id = req.user.user_id

    const attendee = await eventService.rsvp(event_id, user_id, value.status)

    res.json({ attendee })
  } catch (err) {
    console.error('RSVP error', err)
    res.status(500).json({ error: 'Internal server error' })
  }
}

module.exports = {
  createEvent,
  getAllEvents,
  getMyEvents,
  rsvp
}