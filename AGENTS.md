# PROJECT KNOWLEDGE BASE

**Generated:** 2025-01-21
**Commit:** main
**Branch:** main

## OVERVIEW
Full-stack memory management app with React frontend and Express.js backend.

## STRUCTURE
```
/
├── memora-frontend/    # React + Vite + Tailwind SPA
├── memora-backend/     # Express.js API server
├── shared/             # Shared utilities/types
└── package.json        # Workspace configuration
```

## WHERE TO LOOK
| Task | Location | Notes |
|------|----------|-------|
| Frontend components | memora-frontend/src/components/ | 20 files, high complexity in Dashboard.jsx |
| Frontend routing | memora-frontend/src/routes/ | 5 route files |
| API endpoints | memora-backend/routes/ | Express REST endpoints |
| Database models | memora-backend/models/ | Data schemas |
| Shared types | shared/ | TypeScript interfaces |

## CONVENTIONS
- Frontend: Functional components with hooks, Tailwind CSS classes
- Backend: Express.js REST API, separate route files by feature
- Config: ESLint with React rules, Vite with API proxy to backend

## COMMANDS
```bash
# Frontend development
cd memora-frontend && npm run dev

# Backend development  
cd memora-backend && npm start

# Full stack (from root)
npm run dev:frontend
npm run dev:backend
```

## NOTES
- Backend runs on port 3001, frontend dev server on 5173
- Multer used for file uploads (deprecation warning on req.file)
- No backend ESLint configuration present
- Dashboard.jsx is complex with 20+ state variables and mixed concerns