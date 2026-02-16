-- db/schema.sql
-- Oyaura: Productivity & Wellness App 

-- 1. Enable UUIDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. Users Table (Updated for Wellness)
DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users (
  user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  username VARCHAR(100) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  avatar_style VARCHAR(50), -- For the "Customizable Avatar" in PDF
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- 3. Mood Journal (The Core Feature)
DROP TABLE IF EXISTS mood_logs CASCADE;
CREATE TABLE mood_logs (
  log_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL,
  mood_score INT NOT NULL, -- e.g., 1-5 scale
  notes TEXT, -- The "Journal" part
  logged_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  CONSTRAINT fk_mood_user FOREIGN KEY (user_id)
    REFERENCES users(user_id) ON DELETE CASCADE
);

-- 4. Goals & Habits
DROP TABLE IF EXISTS goals CASCADE;
CREATE TABLE goals (
  goal_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL,
  title VARCHAR(255) NOT NULL,
  is_completed BOOLEAN DEFAULT FALSE,
  streak_count INT DEFAULT 0, -- For the "Streak System" in PDF
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  CONSTRAINT fk_goal_user FOREIGN KEY (user_id)
    REFERENCES users(user_id) ON DELETE CASCADE
);

-- 5. Resources (Optional: Wellness Tips)
DROP TABLE IF EXISTS resources CASCADE;
CREATE TABLE resources (
  resource_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  category VARCHAR(50) -- e.g., "Meditation", "Focus"
);