# PROJECT KNOWLEDGE BASE

**Generated:** 2026-03-28
**Commit:** main
**Branch:** main

## OVERVIEW

Full-stack memory learning platform with React frontend and Express backend, using Bun for local workflows and Vercel for deployment.

## STRUCTURE

```
/
├── memora-frontend/    # React + Vite SPA
├── memora-backend/     # Express API + serverless entrypoint
├── vercel.json         # Monorepo deployment routing/build config
└── docs/               # Specs and planning artifacts
```

## WHERE TO LOOK

| Task | Location | Notes |
|------|----------|-------|
| Frontend pages/components | `memora-frontend/src/pages`, `memora-frontend/src/components` | Largest UI surface area |
| Frontend services | `memora-frontend/src/services` | API + journal logic |
| Backend API routes | `memora-backend/routes` | Feature-based REST handlers |
| Backend app wiring | `memora-backend/app.js`, `memora-backend/server.js` | Express app + local server bootstrap |
| Vercel API entrypoint | `memora-backend/api/index.js` | Serverless handler export |

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

Required environment variables on Vercel (Backend Project):
- `JWT_SECRET`
- `JWT_REFRESH_SECRET`
- `MONGODB_URI`
- `FRONTEND_URL` (optional but recommended)

Behavior:
- Frontend calls `"/api"` in production and dev fallback is handled by Vite proxy.
- `vercel.json` routes `/api/*` to `memora-backend/api/index.js` and all SPA routes to `/index.html`.

## NOTES

- Backend still uses Mongoose indexes that currently emit duplicate-index warnings in tests.
- Frontend lint currently passes with **0 errors** and existing hook dependency warnings.
