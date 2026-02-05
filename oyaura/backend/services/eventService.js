// services/eventService.js
const db = require('../db')

async function createEvent(organizer_id, { title, description, event_date, location }) {
  const result = await db.query(
    `INSERT INTO events (organizer_id, title, description, event_date, location)
     VALUES ($1, $2, $3, $4, $5)
     RETURNING event_id, organizer_id, title, description, event_date, location, created_at`,
    [organizer_id, title, description, event_date, location]
  )

  return result.rows[0]
}

async function getAllEvents() {
  const q = await db.query(
    `SELECT e.event_id, e.organizer_id, u.username AS organizer_name,
            e.title, e.description, e.event_date, e.location, e.created_at
     FROM events e
     JOIN users u ON u.user_id = e.organizer_id
     WHERE e.event_date >= now()
     ORDER BY e.event_date ASC`
  )

  return q.rows
}

async function getMyEvents(user_id) {
  const q = await db.query(
    `SELECT e.event_id, e.title, e.description, e.event_date, e.location,
            a.status, a.responded_at, e.created_at, u.username AS organizer_name
     FROM attendees a
     JOIN events e ON e.event_id = a.event_id
     JOIN users u ON u.user_id = e.organizer_id
     WHERE a.user_id = $1
     ORDER BY e.event_date ASC`,
    [user_id]
  )

  return q.rows
}

async function rsvp(event_id, user_id, status) {
  const ev = await db.query('SELECT event_id FROM events WHERE event_id = $1', [event_id])
  if (ev.rows.length === 0) {
    throw new Error('Event not found')
  }

  const responded_at = new Date().toISOString()

  const upsertQuery = `
    INSERT INTO attendees (event_id, user_id, status, responded_at)
    VALUES ($1, $2, $3, $4)
    ON CONFLICT (event_id, user_id) DO UPDATE
      SET status = EXCLUDED.status,
          responded_at = EXCLUDED.responded_at
    RETURNING attendee_id, event_id, user_id, status, responded_at
  `

  const result = await db.query(upsertQuery, [event_id, user_id, status, responded_at])
  return result.rows[0]
}

module.exports = {
  createEvent,
  getAllEvents,
  getMyEvents,
  rsvp
}