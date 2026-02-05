// services/authService.js
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')
const db = require('../db')
require('dotenv').config()

const saltRounds = parseInt(process.env.BCRYPT_SALT_ROUNDS || '10', 10)

async function signup({ username, email, password }) {
  const existing = await db.query(
    'SELECT user_id FROM users WHERE email = $1',
    [email]
  )

  if (existing.rows.length > 0) {
    return { error: 'Email already registered' }
  }

  const password_hash = await bcrypt.hash(password, saltRounds)

  const result = await db.query(
    `INSERT INTO users (username, email, password_hash)
     VALUES ($1, $2, $3)
     RETURNING user_id, username, email, created_at`,
    [username, email, password_hash]
  )

  const user = result.rows[0]

  // Auto-login after signup
  const token = jwt.sign(
    { user_id: user.user_id, email: user.email },
    process.env.JWT_SECRET,
    { expiresIn: process.env.JWT_EXPIRES_IN || '7d' }
  )

  return { token, user }
}

async function login({ email, password }) {
  const q = await db.query(
    'SELECT user_id, username, email, password_hash FROM users WHERE email = $1',
    [email]
  )

  if (q.rows.length === 0) {
    return { error: 'Invalid email or password' }
  }

  const user = q.rows[0]
  const match = await bcrypt.compare(password, user.password_hash)

  if (!match) {
    return { error: 'Invalid email or password' }
  }

  const token = jwt.sign(
    { user_id: user.user_id, email: user.email },
    process.env.JWT_SECRET,
    { expiresIn: process.env.JWT_EXPIRES_IN || '7d' }
  )

  return {
    token,
    user: {
      user_id: user.user_id,
      username: user.username,
      email: user.email
    }
  }
}

module.exports = {
  signup,
  login
}