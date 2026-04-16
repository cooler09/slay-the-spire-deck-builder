-- Initial Schema for Slay the Spire Deck Builder
-- Run this script in Supabase SQL Editor

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email VARCHAR(255) UNIQUE NOT NULL,
  username VARCHAR(100) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  bio TEXT,
  avatar_url VARCHAR(500)
);

-- Decks table
CREATE TABLE decks (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  deck_class VARCHAR(50), -- Ironclad, Silent, Watcher, Defect
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  is_public BOOLEAN DEFAULT FALSE,
  view_count INTEGER DEFAULT 0
);

-- Cards table
CREATE TABLE cards (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL UNIQUE,
  card_class VARCHAR(50) NOT NULL,
  card_type VARCHAR(50), -- Attack, Skill, Power, Status
  cost INTEGER,
  description TEXT,
  rarity VARCHAR(50), -- Common, Uncommon, Rare, etc.
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Deck composition (many-to-many: Decks -> Cards)
CREATE TABLE deck_cards (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  deck_id UUID NOT NULL REFERENCES decks(id) ON DELETE CASCADE,
  card_id UUID NOT NULL REFERENCES cards(id) ON DELETE CASCADE,
  quantity INTEGER DEFAULT 1,
  added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(deck_id, card_id)
);

-- Likes/Favorites table
CREATE TABLE deck_likes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  deck_id UUID NOT NULL REFERENCES decks(id) ON DELETE CASCADE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(user_id, deck_id)
);

-- Comments table
CREATE TABLE comments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  deck_id UUID NOT NULL REFERENCES decks(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better query performance
CREATE INDEX idx_decks_user_id ON decks(user_id);
CREATE INDEX idx_decks_is_public ON decks(is_public);
CREATE INDEX idx_deck_cards_deck_id ON deck_cards(deck_id);
CREATE INDEX idx_deck_likes_user_id ON deck_likes(user_id);
CREATE INDEX idx_comments_deck_id ON comments(deck_id);

-- Enable Row Level Security
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE decks ENABLE ROW LEVEL SECURITY;
ALTER TABLE comments ENABLE ROW LEVEL SECURITY;

-- Create basic RLS policies
CREATE POLICY "Users can view their own profile" ON users
  FOR SELECT USING (true); -- Allow read for now

CREATE POLICY "Users can update their own profile" ON users
  FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Anyone can view public decks" ON decks
  FOR SELECT USING (is_public = TRUE OR user_id = auth.uid());

CREATE POLICY "Users can create their own decks" ON decks
  FOR INSERT WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update their own decks" ON decks
  FOR UPDATE USING (user_id = auth.uid());

CREATE POLICY "Users can delete their own decks" ON decks
  FOR DELETE USING (user_id = auth.uid());
