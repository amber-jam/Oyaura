// routes/events.js
const express = require('express')
const router = express.Router()
const authenticate = require('../middleware/auth')
const eventController = require('../controllers/eventController')

router.post('/', authenticate, eventController.createEvent)
router.get('/', eventController.getAllEvents)
router.get('/my-events', authenticate, eventController.getMyEvents)
router.post('/:id/rsvp', authenticate, eventController.rsvp)

module.exports = router