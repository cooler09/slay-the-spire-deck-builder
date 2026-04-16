# Slay the Spire Deck Builder

A free, open-source deck builder for Slay the Spire with a modern web interface.

## 📋 Project Structure

```
slay-the-spire-deck-builder/
├── frontend/              # React UI (deployed to Vercel)
│   ├── src/
│   ├── public/
│   └── package.json
├── backend/               # API endpoints (Vercel Functions)
│   ├── api/
│   ├── utils/
│   └── package.json
├── database/              # Database configuration & migrations
│   └── migrations/
└── README.md

# AI Agent Skills (at workspace root)
copilot-skills/
├── README.md              # Skills documentation
└── deck-builder/          # Deck builder domain knowledge
    ├── SKILL.md
    └── .instructions.md
```

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ 
- npm or yarn
- Git

### Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/slay-the-spire-deck-builder.git
cd slay-the-spire-deck-builder
```

2. Install dependencies (monorepo setup)
```bash
npm install
```

3. Setup environment variables
```bash
cp .env.example .env.local
```

4. Start development servers
```bash
npm run dev
```

## 🛠️ Development

### Frontend Development
```bash
cd frontend
npm run dev
```

### Backend Development
```bash
cd backend
npm run dev
```

### Database Migrations
See [database/migrations](./database/migrations) for setup instructions.

## 🌐 Deployment

### Frontend (Vercel)
- Automatically deploys on push to main branch
- Configure in `frontend/vercel.json`

### Backend (Vercel Functions)
- API routes in `backend/api/`
- Automatically deployed with frontend

### Database (Supabase)
- Connection string in `.env.local`
- Migrations run via CLI

## 📦 Tech Stack

- **Frontend**: React + TypeScript
- **Hosting**: Vercel
- **Backend**: Vercel Functions / Node.js
- **Database**: Supabase (PostgreSQL)
- **CI/CD**: GitHub Actions

## 🤖 AI Agent Skills

See [copilot-skills/](../copilot-skills/) at workspace root for AI assistant configurations and tools.

## 📄 License

MIT License - see LICENSE file for details

## 🤝 Contributing

Contributions welcome! Please read CONTRIBUTING.md first.
