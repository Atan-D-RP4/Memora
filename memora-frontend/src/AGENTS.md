# FRONTEND SOURCE - React Application

**Scope**: Frontend source directory `memora-frontend/src` **Generated**:
2025-01-21

## Overview

Main React application source with routing, components, and utilities.

## Structure

```
memora-frontend/src/
├── components/          # React components (see components/AGENTS.md)
├── pages/              # Route page components (13 files)
├── routes/             # React Router configuration (5 files)
├── hooks/              # Custom React hooks
├── services/           # API service layers
├── utils/              # Utility functions
├── contexts/           # React contexts
├── assets/             # Static assets
└── main.jsx            # Application entry point
```

## Where To Look

| Task              | Location  | Notes                               |
| ----------------- | --------- | ----------------------------------- |
| Route definitions | routes/   | Express.js style routing setup      |
| Page components   | pages/    | Route-specific page implementations |
| Custom hooks      | hooks/    | Reusable React hook logic           |
| API calls         | services/ | Backend communication layer         |
| State management  | contexts/ | React context providers             |
| Routing setup     | main.jsx  | App initialization and router       |

## Conventions

- React Router v6 for navigation
- File-based routing structure
- Separation of concerns (pages vs components)
- Service layer for API calls
- Context for global state

## Anti-Patterns (This Project)

- **Mixed routing styles**: Some routing logic scattered across components
- **Service inconsistency**: API calls sometimes in components directly

## Notes

- Main.jsx is the application entry point with router setup
- Components directory has its own AGENTS.md for detailed component guidance
- Pages directory contains route-level components that compose components/

## Commands

```bash
# Development server
bun run dev

# Lint, tests, and build
bun run lint
bun run test
bun run build

# Preview production build
bun run preview
```

## Deployment Notes

- Frontend service layer defaults to `"/api"` in production (`VITE_API_URL` can override).
- Root `vercel.json` handles API routing to backend serverless entrypoint and SPA fallback to `index.html`.
