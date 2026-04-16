# Project Structure Overview

Complete folder structure and file reference for the Slay the Spire Deck Builder monorepo.

```
/github/
├── copilot-skills/               # AI Assistant skills (workspace root)
│   ├── README.md                # Skills documentation
│   └── deck-builder/
│       ├── SKILL.md             # Domain knowledge & best practices
│       └── .instructions.md     # Copilot project instructions
│
└── slay-the-spire-deck-builder/  # Monorepo (main project)
    │
    ├── .github/
    │   └── workflows/
    │       └── ci-cd.yml                 # GitHub Actions CI/CD pipeline
    │
    ├── frontend/                         # React UI (Vercel deployment)
    │   ├── src/
    │   │   ├── App.tsx                 # Main React component
    │   │   ├── main.tsx                # Entry point
    │   │   └── index.css               # Global styles
    │   ├── public/
    │   │   └── manifest.json           # PWA manifest
    │   ├── index.html                  # HTML template
    │   ├── vite.config.ts              # Vite build config
    │   ├── tsconfig.json               # TypeScript config
    │   ├── vercel.json                 # Vercel deployment config
    │   ├── .env.example                # Environment template
    │   ├── package.json                # Dependencies
    │   └── README.md                   # Frontend documentation
    │
    ├── backend/                        # REST API (Vercel Functions)
    │   ├── api/
    │   │   └── index.js               # Express API entry point
    │   ├── utils/
    │   ├── .env.example               # Environment template
    │   ├── package.json               # Dependencies
    │   └── README.md                  # Backend documentation
    │
    ├── database/                      # Database setup & migrations
    │   ├── migrations/
    │   │   └── initial-schema.sql    # Initial PostgreSQL schema
    │   └── README.md                # Database documentation
    │
    ├── .gitignore                    # Git ignore rules
    ├── package.json                  # Root monorepo config
    ├── README.md                     # Main project README
    ├── SETUP.md                      # Complete setup guide ← START HERE
    └── STRUCTURE.md                  # This file

```

## Key Files & Their Purpose

### Configuration Files

| File | Purpose |
|------|---------|
| `package.json` | Monorepo workspace definition |
| `.gitignore` | Git ignore patterns |
| `.env.local` | Local environment variables (not committed) |
| `.github/workflows/ci-cd.yml` | Automated deployment pipeline |

### Frontend

| File | Purpose |
|------|---------|
| `frontend/vite.config.ts` | Build tool configuration |
| `frontend/tsconfig.json` | TypeScript compiler options |
| `frontend/vercel.json` | Vercel deployment settings |
| `frontend/src/App.tsx` | Main React component |
| `frontend/index.html` | HTML entry point |

### Backend

| File | Purpose |
|------|---------|
| `backend/api/index.js` | Express server & API routes |
| `backend/.env.example` | Backend environment template |

### Database

| File | Purpose |
|------|---------|
| `database/migrations/initial-schema.sql` | PostgreSQL table definitions |
| `database/README.md` | Database setup instructions |

### AI Skills (Workspace Root)

| File | Purpose |
|------|----------|
| `../copilot-skills/deck-builder/SKILL.md` | Domain knowledge for Slay the Spire |
| `../copilot-skills/deck-builder/.instructions.md` | Project coding standards |

## Development Workflow

### Creating New Features

1. **Create branch**: `git checkout -b feature/your-feature`
2. **Make changes** in appropriate folder:
   - UI → `frontend/src/components/`
   - API → `backend/api/`
   - Data → `database/migrations/`
3. **Test locally**: `npm run dev`
4. **Commit**: `git add . && git commit -m "feat: description"`
5. **Push**: `git push origin feature/your-feature`
6. **Create PR**: GitHub Pull Request
7. **CI/CD runs**: Automated tests and linting
8. **Merge to main**: Auto-deploys to Vercel

### Adding npm Packages

```bash
# Frontend
cd frontend && npm install package-name

# Backend
cd backend && npm install package-name

# Both
npm install package-name --workspace=frontend --workspace=backend
```

### Creating Database Migrations

1. Create new file: `database/migrations/migration_YYYYMMDD_name.sql`
2. Write SQL changes
3. Test in development Supabase
4. Run in production via Supabase CLI

## Environment Variables

### Frontend (.env.local)
```
VITE_SUPABASE_URL=...
VITE_SUPABASE_ANON_KEY=...
VITE_API_URL=...
```

### Backend (.env.local or Vercel)
```
SUPABASE_URL=...
SUPABASE_KEY=...
NODE_ENV=production
```

## Deployment Checklist

- [ ] All tests passing
- [ ] Environment variables configured in Vercel
- [ ] Database migrations applied
- [ ] No console errors or warnings
- [ ] Preview deployment tested
- [ ] Production deployment verified

## Useful npm Commands

```bash
# Development
npm run dev              # Start all services
cd frontend && npm run dev
cd backend && npm run dev

# Building
npm run build            # Build all packages
npm run build --workspace=frontend

# Testing & Linting
npm test                 # Run tests
npm run lint             # Lint code
npm run type-check       # TypeScript check

# Git & Deploy
git push origin main     # Triggers GitHub Actions → Vercel auto-deploy
```

## Quick Links

- **AI Skills**: `../copilot-skills/deck-builder/` (workspace root)
- **Vercel Dashboard**: https://vercel.com/dashboard
- **Supabase Dashboard**: https://app.supabase.com
- **GitHub Repository**: https://github.com/yourusername/slay-the-spire-deck-builder
- **Production Frontend**: https://slay-the-spire-deck-builder.vercel.app
- **Production API**: https://api-slay-the-spire.vercel.app

## Adding New Folders

### For new frontend feature
```bash
mkdir -p frontend/src/features/feature-name
# Add components, hooks, types inside
```

### For new backend route
```bash
mkdir -p backend/routes/new-route
# Add route handler inside
```

### For new database table
```bash
# Create migration file in database/migrations/
nano database/migrations/migration_YYYYMMDD_table_name.sql
```

## File Size Guidelines

- React components: < 300 lines
- CSS modules: < 200 lines
- Utility functions: < 100 lines
- API routes: < 100 lines

If larger, consider breaking into smaller files.

## Naming Conventions

- **Files**: kebab-case (e.g., `card-builder.tsx`)
- **Folders**: kebab-case (e.g., `card-builder/`)
- **Components**: PascalCase (e.g., `CardBuilder.tsx`)
- **Variables**: camelCase (e.g., `cardCount`)
- **Constants**: UPPER_SNAKE_CASE (e.g., `MAX_DECK_SIZE`)
- **Types**: PascalCase (e.g., `CardType`)

## Branches

- `main`: Production (auto-deploys to Vercel)
- `develop`: Development branch
- `feature/*`: Feature branches
- `bugfix/*`: Bug fix branches
- `docs/*`: Documentation branches

## Need Help?

1. **Setup issues?** → See [SETUP.md](./SETUP.md)
2. **Domain knowledge?** → See [../copilot-skills/deck-builder/SKILL.md](../copilot-skills/deck-builder/SKILL.md)
3. **Coding standards?** → See [../copilot-skills/deck-builder/.instructions.md](../copilot-skills/deck-builder/.instructions.md)
4. **Database questions?** → See [database/README.md](./database/README.md)

---

**Last Updated**: April 15, 2024  
**Version**: 1.0.0
