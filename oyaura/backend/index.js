const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');
require('dotenv').config();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const app = express();
const port = process.env.PORT || 4000;

// Middleware
app.use(cors());
app.use(express.json());

// --- DATABASE CONNECTION (FIXED FOR SUPABASE) ---
const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
  ssl: {
    rejectUnauthorized: false
  }
});

// --- ROUTES ---

// 1. REGISTER USER
app.post('/register', async (req, res) => {
  try {
    const { username, email, password } = req.body;

    const userCheck = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
    if (userCheck.rows.length > 0) {
      return res.status(401).json({ error: "User already exists!" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    
    const newUser = await pool.query(
      'INSERT INTO users (username, email, password_hash) VALUES ($1, $2, $3) RETURNING user_id, username, email',
      [username, email, hashedPassword]
    );
    
    res.json(newUser.rows[0]);
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: err.message });
  }
});

// 2. LOGIN USER
app.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await pool.query('SELECT * FROM users WHERE email = $1', [email]);

    if (user.rows.length === 0) {
      return res.status(401).json({ error: "Password or Email is incorrect" });
    }

    const validPassword = await bcrypt.compare(password, user.rows[0].password_hash);
    if (!validPassword) {
      return res.status(401).json({ error: "Password or Email is incorrect" });
    }

    // FIXED LINE: No line breaks in the middle of the string
    const token = jwt.sign({ user_id: user.rows[0].user_id }, process.env.JWT_SECRET || 'secret', { expiresIn: "1h" });
    
    res.json({ token, user: user.rows[0] });
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: err.message });
  }
});

// 3. LOG MOOD
app.post('/moods', async (req, res) => {
  try {
    const { user_id, mood_score, notes } = req.body;
    const newMood = await pool.query(
      'INSERT INTO mood_logs (user_id, mood_score, notes) VALUES ($1, $2, $3) RETURNING *',
      [user_id, mood_score, notes]
    );
    res.json(newMood.rows[0]);
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: err.message });
  }
});

// 4. GET MOOD HISTORY
app.get('/moods/:user_id', async (req, res) => {
  try {
    const { user_id } = req.params;
    const moods = await pool.query('SELECT * FROM mood_logs WHERE user_id = $1 ORDER BY logged_at DESC', [user_id]);
    res.json(moods.rows);
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: err.message });
  }
});

// 5. CREATE GOAL
app.post('/goals', async (req, res) => {
  try {
    const { user_id, title } = req.body;
    const newGoal = await pool.query(
      'INSERT INTO goals (user_id, title) VALUES ($1, $2) RETURNING *',
      [user_id, title]
    );
    res.json(newGoal.rows[0]);
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: err.message });
  }
});

// 6. GET GOALS
app.get('/goals/:user_id', async (req, res) => {
  try {
    const { user_id } = req.params;
    const goals = await pool.query('SELECT * FROM goals WHERE user_id = $1', [user_id]);
    res.json(goals.rows);
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: err.message });
  }
});

app.listen(port, () => {
  console.log(`Oyaura Server running on port ${port}`);
});