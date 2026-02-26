const express = require("express");
const cors = require("cors");
const pool = require("./db"); // This connects to your database

const app = express();

// --- MIDDLEWARE ---
app.use(cors());
app.use(express.json()); // Allows us to read JSON data sent from Flutter
// Simple ping endpoint for connectivity testing
app.get('/ping', (req, res) => {
  res.json({ message: 'pong' });
});

// ==========================================
// USER AUTHENTICATION ROUTES
// ==========================================

// 1. SIGN UP (Create a new user)
app.post('/signup', async (req, res) => {
  try {
    const { username, email, password } = req.body; 
    
    // A. Check if user already exists
    const userCheck = await pool.query("SELECT * FROM users WHERE email = $1", [email]);
    if (userCheck.rows.length > 0) {
      return res.status(401).json("User already exists!");
    }

    // B. Create the new user
    const newUser = await pool.query(
      "INSERT INTO users (username, email, password_hash) VALUES ($1, $2, $3) RETURNING *",
      [username, email, password]
    );

    // C. Send back the new User ID
    res.json(newUser.rows[0]);
    
  } catch (err) {
    console.error(err.message);
    res.status(500).json("Server Error");
  }
});

// 2. LOGIN (Find existing user)
app.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    
    // A. Find user by email
    const user = await pool.query("SELECT * FROM users WHERE email = $1", [email]);
    
    if (user.rows.length === 0) {
      return res.status(401).json("Password or Email is incorrect");
    }

    // B. Check password
    if (password === user.rows[0].password_hash) {
      res.json(user.rows[0]); // Send back user info
    } else {
      res.status(401).json("Password or Email is incorrect");
    }
  } catch (err) {
    console.error(err.message);
    res.status(500).json("Server Error");
  }
});

// ==========================================
// GOAL ROUTES
// ==========================================

// 3. GET GOALS (Fetch specific user's goals)
app.get('/goals/:user_id', async (req, res) => {
  try {
    const { user_id } = req.params;
    // Order by: Not Completed first -> Priority -> Date
    const allGoals = await pool.query(
      `SELECT * FROM goals 
       WHERE user_id = $1 
       ORDER BY is_completed ASC, 
       CASE WHEN priority = 'High' THEN 1 WHEN priority = 'Medium' THEN 2 ELSE 3 END, 
       target_date ASC`, 
      [user_id]
    );
    res.json(allGoals.rows);
  } catch (err) {
    console.error(err.message);
    res.status(500).json("Server Error");
  }
});

// 4. CREATE GOAL
app.post('/goals', async (req, res) => {
  try {
    const { user_id, title, description, target_date, priority, category } = req.body;
    
    const newGoal = await pool.query(
      `INSERT INTO goals (user_id, title, description, target_date, priority, category) 
       VALUES ($1, $2, $3, $4, $5, $6) 
       RETURNING *`,
      [user_id, title, description, target_date, priority, category]
    );
    
    res.json(newGoal.rows[0]);
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: err.message });
  }
});

// 5. TOGGLE CHECKMARK (Update status)
app.put('/goals/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { is_completed } = req.body;
    
    await pool.query(
      "UPDATE goals SET is_completed = $1 WHERE goal_id = $2",
      [is_completed, id]
    );
    
    res.json("Goal updated!");
  } catch (err) {
    console.error(err.message);
    res.status(500).json("Server Error");
  }
});

// 6. DELETE GOAL
app.delete('/goals/:id', async (req, res) => {
  try {
    const { id } = req.params;
    await pool.query("DELETE FROM goals WHERE goal_id = $1", [id]);
    res.json("Goal deleted!");
  } catch (err) {
    console.error(err.message);
  }
});

app.listen(4000, () => {
  console.log("Oyaura Server running on port 4000");
});