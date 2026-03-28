# BACKEND KNOWLEDGE BASE

**Generated:** 2025-01-21 **Commit:** main **Branch:** main

## OVERVIEW

Express.js REST API with MongoDB, JWT auth, and SM-2 spaced repetition
algorithm.

## STRUCTURE

```
memora-backend/
├── config/          # Configuration files
├── middleware/      # Custom Express middleware
├── models/          # Mongoose ODM schemas
├── routes/          # API route handlers by feature
├── scripts/         # Database utility scripts
├── uploads/         # File upload storage
├── utils/           # JWT token utilities
└── server.js        # Express server entry point
```

## WHERE TO LOOK

| Task             | Location                         | Notes                                                          |
| ---------------- | -------------------------------- | -------------------------------------------------------------- |
| API endpoints    | routes/                          | Separate files: auth, user, topics, doctags, journal           |
| Database schemas | models/                          | User, Topic, RevisionHistory, SpacedRepetitionSchedule, DocTag |
| JWT auth         | utils/jwt.js, middleware/auth.js | Access/refresh token rotation, optionalAuth helper             |
| Input validation | routes/*.js                      | express-validator with handleValidationErrors helper           |
| File uploads     | routes/doctags.js                | multer (deprecation warning on req.file)                       |

## CONVENTIONS

- **Routes**: Feature-based files (auth.js, user.js, topics.js), RESTful
  patterns
- **Auth**: JWT with access (15min) and refresh (7 days) token rotation
- **Responses**: { success: boolean, message: string, data?: any, errors?: array
  }
- **Validation**: express-validator arrays before route handlers
- **Database**: Mongoose ODM with schema methods for complex queries
- **Error handling**: Try-catch blocks, console.error logging, development error
  messages

## ANTI-PATTERNS

- Rate limiting disabled in development (lines 14-19 in server.js)
- MongoDB connection non-blocking - continues without DB in dev (line 48)
- Some authentication middleware temporarily disabled for debugging (topics.js)
- console.log statements in production routes for debugging

## NOTES

- Runs on port 3001 (not 3000 as parent docs state)
- Token secrets required in .env (JWT_SECRET, JWT_REFRESH_SECRET)
- Helmet.js security headers configured
- CORS allows localhost:5173, devtunnels, and FRONTEND_URL
- Multer deprecation warning: req.file deprecated, use req.files

## COMMANDS

```bash
# Development server
bun run dev

# Production start
bun run start

# Test script (currently placeholder in package.json)
bun run test
```
