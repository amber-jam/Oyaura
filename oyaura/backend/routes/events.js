const express = require('express');
const router = express.Router();
const Joi = require('joi');
const db = require('../db');
const authenticate = require('../middleware/auth');

const eventCreateSchema = Joi.object({
  title: Joi.string().max(255).required(),
  description: Joi.string().allow('', null),
  event_date: Joi.date().iso().required(),
  location: Joi.string().max(255).allow('', null)
});

router.post('/', authenticate, async (req, res) => {
  try {
    const { error, value } = eventCreateSchema.validate(req.body);
    if (error) return res.status(400).json({ error: error.details[0].message });

    const { title, description, event_date, location } = value;
    const organizer_id = req.user.user_id;

    const result = await db.query(
      `INSERT INTO events (organizer_id, title, description, event_date, location)
       VALUES ($1, $2, $3, $4, $5)
       RETURNING event_id, organizer_id, title, description, event_date, location, created_at`,
      [organizer_id, title, description, event_date, location]
    );

    res.status(201).json({ event: result.rows[0] });
  } catch (err) {
    console.error('Create event error', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

router.get('/', async (req, res) => {
  try {
    const q = await db.query(
      `SELECT e.event_id, e.organizer_id, u.username AS organizer_name, e.title, e.description, e.event_date, e.location, e.created_at
       FROM events e
       JOIN users u ON u.user_id = e.organizer_id
       WHERE e.event_date >= now()
       ORDER BY e.event_date ASC`
    );
    res.json({ events: q.rows });
  } catch (err) {
    console.error('Fetch events error', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

router.get('/my-events', authenticate, async (req, res) => {
  try {
    const user_id = req.user.user_id;
    const q = await db.query(
      `SELECT e.event_id, e.title, e.description, e.event_date, e.location, a.status, a.responded_at, e.created_at, u.username AS organizer_name
       FROM attendees a
       JOIN events e ON e.event_id = a.event_id
       JOIN users u ON u.user_id = e.organizer_id
       WHERE a.user_id = $1
       ORDER BY e.event_date ASC`,
      [user_id]
    );
    res.json({ events: q.rows });
  } catch (err) {
    console.error('Fetch my-events error', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

const rsvpSchema = Joi.object({
  status: Joi.string().valid('going', 'maybe', 'invited', 'declined').required()
});

router.post('/:id/rsvp', authenticate, async (req, res) => {
  try {
    const { error, value } = rsvpSchema.validate(req.body);
    if (error) return res.status(400).json({ error: error.details[0].message });

    const event_id = req.params.id;
    const user_id = req.user.user_id;
    const status = value.status;
    const responded_at = new Date().toISOString();

    const ev = await db.query('SELECT event_id FROM events WHERE event_id = $1', [event_id]);
    if (ev.rows.length === 0) {
      return res.status(404).json({ error: 'Event not found' });
    }

    const upsertQuery = `
      INSERT INTO attendees (event_id, user_id, status, responded_at)
      VALUES ($1, $2, $3, $4)
      ON CONFLICT (event_id, user_id) DO UPDATE
        SET status = EXCLUDED.status,
            responded_at = EXCLUDED.responded_at
      RETURNING attendee_id, event_id, user_id, status, responded_at
    `;
    const result = await db.query(upsertQuery, [event_id, user_id, status, responded_at]);

    res.json({ attendee: result.rows[0] });
  } catch (err) {
    console.error('RSVP error', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

module.exports = router;
