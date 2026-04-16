# Project Setup Guide

Complete walkthrough for setting up the Slay the Spire Deck Builder with Vercel, Supabase, and GitHub Actions CI/CD.

## Prerequisites

- **Node.js**: 18+ ([download](https://nodejs.org/))
- **Git**: Latest version ([download](https://git-scm.com/))
- **GitHub Account**: ([github.com](https://github.com))
- **Code Editor**: VS Code recommended

## Step 1: Initialize Git Repository

```bash
cd /Users/zachary/Documents/projects/github/slay-the-spire-deck-builder

# Initialize git if not already done
git init
git add .
git commit -m "Initial project setup"

# Create and push to GitHub
# (After creating repo on github.com)
git remote add origin https://github.com/yourusername/slay-the-spire-deck-builder.git
git branch -M main
git push -u origin main
```

## Step 2: Setup Supabase (Free Database)

### 2.1 Create Supabase Project

1. Go to [supabase.com](https://supabase.com)
2. Click **"Start your project"**
3. Sign in with GitHub (recommended)
4. Create new project:
   - **Name**: `slay-the-spire-deck-builder`
   - **Database Password**: Save securely
   - **Region**: Closest to you
   - **Plan**: Free tier

### 2.2 Run Database Schema

1. Wait for database to initialize (~1 minute)
2. In Supabase dashboard, go to **SQL Editor**
3. Click **"New Query"**
4. Copy contents of `database/migrations/initial-schema.sql`
5. Paste into SQL editor
6. Click **"Run"**

### 2.3 Get Connection Credentials

1. Go to **Settings** → **Database**
2. Copy **Connection String** (PostgreSQL URI format)
3. In project root, create `.env.local`:

```bash
# Supabase
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_KEY=your-anon-key-here
SUPABASE_SERVICE_ROLE_KEY=your-service-key-here

# Frontend (Vite)
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key-here
VITE_API_URL=http://localhost:3001
```

4. Find keys in **Settings** → **API**:
   - `anon public` key (put in `SUPABASE_KEY`)
   - `service_role secret` key (put in `SUPABASE_SERVICE_ROLE_KEY`)

## Step 3: Setup Vercel (Free Hosting)

### 3.1 Connect Vercel to GitHub

1. Go to [vercel.com](https://vercel.com)
2. Sign up with GitHub
3. On dashboard, click **"Import Project"**
4. Select **"Import Git Repository"**
5. Paste: `https://github.com/yourusername/slay-the-spire-deck-builder`
6. Click **"Continue"**

### 3.2 Configure Vercel Project

1. **Project Name**: `slay-the-spire-deck-builder`
2. **Root Directory**: `./frontend`
3. **Build Settings**:
   - Build Command: `npm run build`
   - Output Directory: `dist`
4. **Environment Variables**:
   ```
   VITE_SUPABASE_URL=your-supabase-url
   VITE_SUPABASE_ANON_KEY=your-anon-key
   VITE_API_URL=https://your-vercel-api-domain.vercel.app
   ```
5. Click **"Deploy"**

### 3.3 Deploy Backend API

1. After frontend deploys, go back to Vercel
2. Create new project from same repo
3. **Root Directory**: `./backend`
4. Same **Environment Variables**
5. Click **"Deploy"**
6. Copy the deployment URL (e.g., `https://api-slay-the-spire.vercel.app`)

### 3.4 Update Frontend Environment

1. In Vercel dashboard for frontend
2. Go to **Settings** → **Environment Variables**
3. Update `VITE_API_URL` to your backend URL
4. Redeploy frontend

## Step 4: Setup GitHub Actions (CI/CD)

### 4.1 Add Vercel Secrets

1. In GitHub, go to your repo
2. **Settings** → **Secrets and variables** → **Actions**
3. Add new secrets:
   - `VERCEL_TOKEN`: [Get from Vercel](https://vercel.com/account/tokens)
   - `VERCEL_ORG_ID`: From Vercel dashboard Settings
   - `VERCEL_PROJECT_ID`: From frontend project Settings
   - `SUPABASE_URL`: Your Supabase URL
   - `SUPABASE_KEY`: Your Supabase anon key

### 4.2 Verify Workflow

1. Go to the **Actions** tab
2. See **"CI/CD Pipeline"** workflow
3. Push a test commit to trigger it:

```bash
echo "# Setup complete" >> SETUP.md
git add SETUP.md
git commit -m "test: trigger CI/CD pipeline"
git push
```

4. Watch the workflow run automatically

## Step 5: Local Development

### 5.1 Install Dependencies

```bash
# From project root
npm install
```

### 5.2 Create .env.local

Copy from frontend and backend `.env.example` files:

```bash
cp frontend/.env.example .env.local
cp backend/.env.example .env.local.backend
```

Edit both with your Supabase credentials.

### 5.3 Start Development Servers

**Terminal 1 - Frontend:**
```bash
cd frontend
npm run dev
# Opens at http://localhost:5173
```

**Terminal 2 - Backend:**
```bash
cd backend
npm run dev
# Starts at http://localhost:3001
```

## Step 6: Verify Everything Works

### 6.1 Test Frontend
- Visit `http://localhost:5173`
- See Deck Builder homepage
- Check browser console for errors

### 6.2 Test API
```bash
curl http://localhost:3001/api/health
# Should return: {"status":"ok","timestamp":"..."}
```

### 6.3 Test Database
1. In Supabase dashboard → **SQL Editor**
2. Create new query:
```sql
SELECT COUNT(*) FROM users;
```

## Step 7: Deploy to Production

### 7.1 Make a Commit

```bash
git add .
git commit -m "feat: initial deck builder setup"
git push origin main
```

### 7.2 Monitor Deployment

1. GitHub Actions runs automatically
2. Frontend deploys to Vercel
3. Backend deploys to Vercel (separate project)
4. Visit your production URLs

### 7.3 Verify Production

- Visit `https://your-project.vercel.app`
- Check API at `https://your-api.vercel.app/api/health`
- Test Supabase connection from production

## Troubleshooting

### Supabase Connection Error
```
Error: Failed to connect to database
```
- Check `.env.local` has correct URL and key
- Verify IP whitelist in Supabase (usually auto-configured)
- Try restarting the development server

### Vercel Deployment Fails
- Check build logs in Vercel dashboard
- Verify environment variables are set
- Ensure Node version is 18+
- Check `.github/workflows/ci-cd.yml` for errors

### GitHub Actions Won't Deploy
- Verify `VERCEL_TOKEN` is set correctly
- Check `VERCEL_ORG_ID` and `VERCEL_PROJECT_ID`
- Ensure repo integration is enabled in Vercel

### Port Already in Use
```bash
# Frontend (5173)
lsof -i :5173 | grep LISTEN | awk '{print $2}' | xargs kill -9

# Backend (3001)
lsof -i :3001 | grep LISTEN | awk '{print $2}' | xargs kill -9
```

## Next Steps

1. **Add Authentication**: Connect Supabase Auth to frontend
2. **Implement Card Database**: Load Slay the Spire card data
3. **Build Deck Editor**: UI for adding/removing cards
4. **Add Social Features**: User profiles, sharing, comments
5. **Deploy to Custom Domain**: Buy domain, connect to Vercel

## Useful Commands

```bash
# Start all services
npm run dev

# Build for production
npm run build

# Run linter
npm run lint

# Type checking
npm run type-check

# Database migrations
psql $DATABASE_URL < database/migrations/migration.sql
```

## Resources

- [Vercel Docs](https://vercel.com/docs)
- [Supabase Docs](https://supabase.com/docs)
- [React Documentation](https://react.dev)
- [Vite Configuration](https://vitejs.dev/config/)
- [GitHub Actions](https://docs.github.com/en/actions)

## Support

- Check the AI skills in `../copilot-skills/` (workspace root) for domain knowledge
- Review existing project structure for patterns
- Consult component examples in `frontend/src/`

---

**Setup Status**: ✅ Complete
**Last Updated**: April 15, 2024
