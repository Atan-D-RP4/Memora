# PROJECT KNOWLEDGE BASE

**Generated:** 2026-03-30
**Commit:** main
**Branch:** main

## OVERVIEW

Full-stack memory learning platform with React frontend and Express backend, using Bun for local workflows and Vercel for deployment.

## STRUCTURE

```
/
├── api/                    # Vercel serverless functions (root level for Vercel)
├── memora-frontend/       # React + Vite SPA
├── memora-backend/        # Express API (local dev only)
├── package.json           # Root package.json for Vercel serverless deps
├── vercel.json           # Vercel build + routing config
└── docs/                 # Specs and planning artifacts
```

## WHERE TO LOOK

| Task | Location | Notes |
|------|----------|-------|
| Frontend pages/components | `memora-frontend/src/pages`, `memora-frontend/src/components` | Largest UI surface area |
| Frontend services | `memora-frontend/src/services` | API + journal logic |
| Backend API routes | `memora-backend/routes` | Feature-based REST handlers |
| Backend app wiring | `memora-backend/app.js`, `memora-backend/server.js` | Express app + local server bootstrap |
| Vercel API entrypoint | `api/index.js` | Root-level serverless handler |
| Vercel config | `vercel.json` | Build commands and routing |

## COMMANDS

```bash
# Frontend development
cd memora-frontend && bun run dev

# Backend development
cd memora-backend && bun run dev

# Frontend quality checks
cd memora-frontend && bun run lint
cd memora-frontend && bun run test
cd memora-frontend && bun run build

# Backend tests
cd memora-backend && bun run test
```

## DEPLOYMENT (VERCEL)

### Vercel CLI Commands

```bash
# Deploy to production
vercel --prod

# Deploy preview (automatic on PR)
vercel

# Force fresh deployment (clear build cache)
vercel --prod --force

# List deployments
vercel ls

# Inspect deployment details
vercel inspect <deployment-url>

# View deployment logs
vercel logs <deployment-url>

# List environment variables
vercel env ls

# Pull environment variables locally
vercel env pull .env

# Link local project to Vercel project
vercel link

# Unlink from Vercel project
vercel unlink
```

### Required Environment Variables

Add these in Vercel project dashboard (Settings → Environment Variables):

| Variable | Description | Example |
|----------|-------------|---------|
| `MONGODB_URI` | MongoDB Atlas connection string | `mongodb+srv://user:pass@cluster.mongodb.net/memora` |
| `JWT_SECRET` | Access token secret (min 32 chars) | `your-super-secret-jwt-key-here` |
| `JWT_REFRESH_SECRET` | Refresh token secret (min 32 chars) | `your-super-secret-refresh-key-here` |
| `NODE_ENV` | Set to `production` | `production` |
| `FRONTEND_URL` | Your Vercel frontend URL | `https://your-app.vercel.app` |

### Vercel Configuration (vercel.json)

```json
{
  "version": 2,
  "installCommand": "cd memora-frontend && npm install --include=dev",
  "buildCommand": "cd memora-frontend && npx vite build",
  "outputDirectory": "memora-frontend/dist",
  "routes": [
    { "src": "/api/(.*)", "dest": "/api/index" },
    { "handle": "filesystem" },
    { "src": "/(.*)", "dest": "/index.html" }
  ]
}
```

### Key Deployment Notes

1. **Root-level API**: Vercel requires serverless functions in `api/` at project root (not `memora-backend/api/`)
2. **Root package.json**: Required for Vercel to install backend dependencies
3. **Backend imports**: `api/index.js` imports from `memora-backend/app.js`
4. **Frontend build**: Must use `--include=dev` to install Vite and its plugins
5. **Routing order**: API routes first, then filesystem (static assets), then SPA fallback

### Troubleshooting

- **Frontend blank page**: Check if JS/CSS assets return 200 (not index.html)
- **API 404**: Ensure `api/index.js` exists at project root
- **API FUNCTION_INVOCATION_FAILED**: Check environment variables are set for Production environment
- **Build fails**: Ensure root `package.json` has all required dependencies

## NOTES

- Backend still uses Mongoose indexes that currently emit duplicate-index warnings in tests.
- Frontend lint currently passes with **0 errors** and existing hook dependency warnings.
- The project uses a dual-folder structure: `memora-backend/` for local dev, `api/` for Vercel serverless
