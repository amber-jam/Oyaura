const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const Joi = require('joi');
const db = require('../db');
require('dotenv').config();

const saltRounds = parseInt(process.env.BCRYPT_SALT_ROUNDS || '10', 10);

const signupSchema = Joi.object({
  username: Joi.string().min(1).max(100).required(),
  email: Joi.string().email().required(),
  password: Joi.string().min(6).required()
});

router.post('/signup', async (req, res) => {
  try {
    const { error, value } = signupSchema.validate(req.body);
    if (error) return res.status(400).json({ error: error.details[0].message });

    const { username, email, password } = value;

    const existing = await db.query('SELECT user_id FROM users WHERE email = $1', [email]);
    if (existing.rows.length > 0) {
      return res.status(409).json({ error: 'Email already registered' });
    }

    const password_hash = await bcrypt.hash(password, saltRounds);
    const result = await db.query(
      'INSERT INTO users (username, email, password_hash) VALUES ($1, $2, $3) RETURNING user_id, username, email, created_at',
      [username, email, password_hash]
    );

    const user = result.rows[0];
    res.status(201).json({ user });
  } catch (err) {
    console.error('Signup error', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

const loginSchema = Joi.object({
  email: Joi.string().email().required(),
  password: Joi.string().required()
});

router.post('/login', async (req, res) => {
  try {
    const { error, value } = loginSchema.validate(req.body);
    if (error) return res.status(400).json({ error: error.details[0].message });

    const { email, password } = value;

    const q = await db.query('SELECT user_id, username, email, password_hash FROM users WHERE email = $1', [email]);
    if (q.rows.length === 0) {
      return res.status(401).json({ error: 'Invalid email or password' });
    }

    const user = q.rows[0];
    const match = await bcrypt.compare(password, user.password_hash);
    if (!match) {
      return res.status(401).json({ error: 'Invalid email or password' });
    }

    const tokenPayload = {
      user_id: user.user_id,
      email: user.email
    };
    const token = jwt.sign(tokenPayload, process.env.JWT_SECRET, { expiresIn: process.env.JWT_EXPIRES_IN || '7d' });

    res.json({ token, user: { user_id: user.user_id, username: user.username, email: user.email } });
  } catch (err) {
    console.error('Login error', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

module.exports = router;
