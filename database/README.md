# Database Setup Guide

This folder contains database schemas and migrations for the Slay the Spire Deck Builder.

## Technology Stack

- **Database**: PostgreSQL (via Supabase)
- **Migrations**: Manual SQL scripts

## Initial Setup

### 1. Create Supabase Project
1. Go to [supabase.com](https://supabase.com)
2. Click "Start your project"
3. Create a new project (free tier recommended)
4. Wait for the database to initialize

### 2. Get Connection Credentials
In Supabase dashboard:
1. Go to Settings → Database
2. Copy the connection string (PostgreSQL URI)
3. Add to `.env.local`:
```
DATABASE_URL=your-connection-string
SUPABASE_URL=your-project-url
SUPABASE_KEY=your-anon-key
```

### 3. Run Initial Schema

Copy and paste the contents of `initial-schema.sql` into the Supabase SQL editor:
1. In Supabase dashboard → SQL Editor
2. New Query
3. Paste the schema SQL
4. Click "Run"

## Migrations

When adding new tables or modifying schema:
1. Create a new file: `migration_YYYYMMDD_description.sql`
2. Write the migration SQL
3. Test in development
4. Run in production when ready

Example:
```sql
-- migration_20240415_add_user_preferences.sql
ALTER TABLE users ADD COLUMN preferences JSONB DEFAULT '{}';
```

## Current Schema

See [initial-schema.sql](./initial-schema.sql) for the current database structure.

## Backup & Recovery

Supabase Free tier includes automatic backups. To export:
1. Supabase Dashboard → Database → Backups
2. Click "Request backup"
3. Download when ready

## Resources

- [Supabase Database Docs](https://supabase.com/docs/guides/database)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
