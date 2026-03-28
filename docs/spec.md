---

# 🧠 Memora — Sets Your Memory in Motion

**An Adaptive Spaced-Repetition Learning Platform**

---

# 1. 🎯 Core Idea

**Memora** is a **spaced-repetition learning assistant** that:

* Tracks **what users need to review** using SM-2 algorithm
* Optimizes **daily cognitive workload** via difficulty-based crowding prevention
* Assesses **baseline memory ability** through a 3-phase cognitive evaluation
* Provides **structured logging** for debugging and analytics
* Uses a **cyber-grid dark UI** for distraction-free learning

---

# 2. 🧠 Core Philosophy

Memora is built on:

* **Spaced Repetition** (SM-2 algorithm)
* **Cognitive Load Optimization** (difficulty-weighted crowding prevention)
* **Memory Assessment** (MemScore evaluation)

---

# 3. 🧩 System Architecture

## Core Components

### 📊 MemScore (Memory Assessment Engine) ✅ Implemented

Initial user memory evaluation using **3 phases**:

#### Phase 1 — Memory Game (Card Matching)

* 4x4 grid of emoji pairs
* 10-second preview before cards flip
* User finds matching pairs
* Measures: Visual recall, pattern recognition
* Scoring: 0 mistakes = 10 points, declining with errors

#### Phase 2 — Tile Recall (Spatial Memory)

* 5 progressive rounds (3→5→7→9→11 tiles)
* Watch tiles light up, reproduce the sequence
* Measures: Spatial memory, sequence retention
* Scoring: 2 points per correct round, -0.5 penalty per mistake

#### Phase 3 — Processing Speed (Rapid Math)

* 30-second rapid-fire arithmetic (addition, subtraction, multiplication)
* Measures: Cognitive processing speed, working memory
* Scoring: (Correct answers / Total questions) × 10

### Result → MemScore (0–10 scale)

* Overall score: average of all three tests
* Stored on user profile as `memScore`
* Configures initial spaced repetition intervals

---

### 🔁 Spaced Repetition Engine ✅ Implemented

SM-2 algorithm with enhancements:

* **Quality ratings**: 0–5 scale (0 = blackout, 5 = perfect)
* **Ease factor**: starts at 2.5, adjusted per review
* **Intervals**: 1 day → 6 days → interval × easeFactor
* **Learning state**: transitions to "learned" after 3+ successful reps at quality ≥ 4
* **Difficulty scale**: 1–5 per topic

#### Crowding Prevention ✅ Implemented

Difficulty-weighted daily load balancing:

* **Thresholds** scale with average topic difficulty
* Easy topics (difficulty 1): can handle 40% more per day
* Hard topics (difficulty 5): reduced by 40%
* Automatic redistribution when a day is crowded
* Skip logic: finds optimal day within 5-day window

---

### 📅 Chronicle (Calendar) ✅ Implemented

Calendar view showing:

* Topic review schedule by date
* Custom events (create, edit, delete)
* Holiday integration (configurable by religion/culture)
* Day detail panel with scheduled topics
* Social sharing (Twitter, LinkedIn, Instagram)

---

### 📎 DocTags (Attachments) ✅ Implemented

Document and folder management:

* File uploads (images, PDFs, documents, videos, archives — 10MB limit)
* External links (YouTube, Google Drive, Notion, GitHub, websites)
* Folder hierarchy with parent-child relationships
* Auto-sync from topics that have attachments/links
* Search, filtering, favorites, recent documents
* Duplicate cleanup utility

---

### 📓 Daily Learning Journal ✅ Implemented

* Auto-logging of topic additions, reviews, skips, edits
* Focus session tracking
* MemScore evaluation logging
* Markdown journal entry generation
* Backend sync for persistence
* GitHub integration for pushing journal entries

---

### 🎯 Focus Mode (Timer) ✅ Implemented

Pomodoro-style study timer:

* Countdown and count-up modes
* Pomodoro sessions (configurable)
* Custom presets
* Fullscreen support
* Session history tracking
* Journal integration (logs focus sessions)

---

### 📈 Analytics Dashboard ✅ Implemented

* MemScore history chart
* Topic performance breakdown
* Study pattern visualization (daily/weekly/monthly)
* Difficulty distribution
* Progress rings and bar charts
* Daily usage tracking
* Time range filtering (7d, 30d, 90d, all)

---

### 🔐 Authentication ✅ Implemented

* JWT access tokens (15min) + refresh tokens (7 days)
* Token rotation on refresh
* bcrypt password hashing (12 salt rounds)
* User profile management
* Preferences (color theme, default difficulty, retention speed)

---

### 📝 Structured Logging ✅ Implemented

Dual-output logging system:

* **Console**: JSON-structured entries (error → console.error, warn → console.warn, info/debug → console.log)
* **Database**: MongoDB `Log` collection with 30-day TTL
* **Levels**: debug (suppressed from console in production), info, warn, error
* **Frontend**: `journalService._log()` POSTs to `/api/logs`
* **Backend**: `require('../utils/logger')('moduleName')` factory
* **Query**: `GET /api/logs` with level/module/pagination filters
* **Fire-and-forget**: logger failures never crash the app

Logged events:

| Module | Events |
|--------|--------|
| topics | prevent-crowding, topic-create, candidate-day, topic-skipped, move-overdue |
| doctags | duplicate-removed, sync-topics, doctag-created/updated, doctags-list |
| journal-service | activity-added, duplicate-skipped, journal-entry-updated, topic/review/skip/edit/focus/memscore logging |

---

# 4. 📱 Frontend Pages

| Page | Route | Description |
|------|-------|-------------|
| Landing | `/` | Marketing page with cyber-grid aesthetic |
| Login | `/login` | JWT authentication |
| SignUp | `/signup` | User registration |
| MemScore Evaluation | `/evaluation` | 3-phase cognitive assessment |
| Dashboard | `/dashboard` | Main hub: due topics, quick actions, MemScore display |
| Topics | `/topics` | Topic CRUD, review, skip, filtering |
| DocTags | `/doctags` | File/folder management, uploads |
| Journal | `/journal` | Daily journal entries, activity log |
| Chronicle | `/chronicle` | Calendar view, events, holidays |
| Analytics | `/analytics` | Charts, stats, progress tracking |
| Focus Mode | `/focus` | Pomodoro timer, session tracking |
| Profile | `/profile` | User profile management |
| Settings | `/settings` | App preferences |

---

# 5. 🔌 API Endpoints

### Auth (`/api/auth`)
| Method | Path | Description |
|--------|------|-------------|
| POST | `/register` | User registration |
| POST | `/login` | User login |
| POST | `/refresh` | Refresh access token |
| POST | `/logout` | User logout |
| GET | `/verify` | Verify token validity |

### User (`/api/user`)
| Method | Path | Description |
|--------|------|-------------|
| GET | `/profile` | Get user profile |
| PUT | `/profile` | Update user profile |
| GET | `/memscore` | Get current MemScore |
| PUT | `/memscore` | Update MemScore |
| GET | `/memscore/history` | Get MemScore history |
| POST | `/evaluation` | Save evaluation results |
| GET | `/preferences` | Get user preferences |
| POST | `/study-session` | Record study session |

### Topics (`/api/topics`)
| Method | Path | Description |
|--------|------|-------------|
| GET | `/` | List topics (filterable) |
| POST | `/` | Create topic |
| GET | `/due` | Get due topics (today + overdue) |
| GET | `/upcoming` | Get upcoming review schedule |
| GET | `/workload` | Get daily workload with crowding analysis |
| POST | `/prevent-crowding` | Redistribute crowded days |
| POST | `/move-overdue` | Move overdue topics to today |
| GET | `/:id` | Get specific topic |
| PUT | `/:id` | Update topic |
| DELETE | `/:id` | Soft-delete topic |
| POST | `/:id/review` | Record review (SM-2) |
| POST | `/:id/skip` | Skip topic (smart redistribution) |

### DocTags (`/api/doctags`)
| Method | Path | Description |
|--------|------|-------------|
| GET | `/` | List documents/folders |
| POST | `/` | Create document/folder |
| POST | `/upload` | Upload files |
| POST | `/cleanup-duplicates` | Remove duplicate entries |
| GET | `/recent` | Get recently accessed docs |
| GET | `/favorites` | Get favorites |
| GET | `/structure/:parentId?` | Get folder structure |
| PUT | `/:id` | Update document/folder |
| DELETE | `/:id` | Soft-delete |

### Journal (`/api/journal`)
| Method | Path | Description |
|--------|------|-------------|
| GET | `/:date` | Get journal entry for date |
| POST | `/` | Create/update journal entry |
| GET | `/weekly/:weekStartDate` | Get weekly entries |
| GET | `/monthly/:year/:month` | Get monthly entries |
| DELETE | `/:date` | Delete journal entry |

### Logs (`/api/logs`)
| Method | Path | Description |
|--------|------|-------------|
| GET | `/` | Query logs (level, module, pagination) |
| POST | `/` | Create frontend log entry |

---

# 6. 🗄️ Database Schema

### User
* `username`, `email`, `password` (bcrypt)
* `memScore` (0–10)
* `hasCompletedEvaluation`, `evaluationResults`
* `preferences` (colorTheme, defaultDifficulty, retentionSpeed, memScoreRecalibrationFreq)
* `currentStreak`, `longestStreak`, `totalStudyDays`, `lastStudyDate`
* `refreshTokens[]`

### Topic
* `title`, `content`, `userId`, `tags[]`, `difficulty` (1–5), `category`
* `attachments[]`, `externalLinks[]`
* SM-2 fields: `easeFactor`, `interval`, `repetitions`, `nextReviewDate`, `isLearning`
* `reviewCount`, `averagePerformance`, `lastReviewed`
* `rescheduleCount`, `isActive`

### DocTag
* `name`, `description`, `type` (folder/document), `category`
* `parentId`, `userId`, `tags[]`, `color`, `icon`
* `attachments[]`, `externalLinks[]`
* `isFavorite`, `isActive`

### Journal
* `userId`, `date`, `content`, `activities[]`

### Log
* `level` (debug/info/warn/error), `module`, `message`, `data`
* `userId`, `source` (backend/frontend)
* `createdAt` (30-day TTL)

### RevisionHistory ✅ Exists (not wired into review flow)
* `userId`, `topicId`, `sessionId`
* `quality` (0–5), `wasCorrect`, `responseTime` (ms)
* `intervalBefore/After`, `easeFactorBefore/After`, `repetitionsBefore/After`
* `timeOfDay` (morning/afternoon/evening/night) — auto-set on save
* `reviewType` (scheduled/manual/cramming), `studyMode`
* `studyDuration` (minutes), `streakBefore/After`
* Static methods: `getUserStats`, `getDailyStats`, `getTopicPerformance`, `getPerformanceByTimeOfDay`, `getCurrentStreak`

### SpacedRepetitionSchedule ✅ Exists (not used at runtime)
* `userId`, `topicId`, `scheduledDate`, `status` (pending/completed/skipped/overdue)
* `priority` (1–10), `estimatedDuration` (minutes), `difficulty` (1–5)
* `timeSlot` (morning/afternoon/evening/night), `isFlexible`
* `cognitiveLoad` (1–10), `userPerformanceAtTime` (0–1)
* `batchId`, `batchPosition`
* `rescheduleCount`, `rescheduleReason`
* Static methods: `getTodaysSchedule`, `getOverdueItems`, `getUpcomingSchedule`, `getByTimeSlot`, `getWorkload`, `optimizeSchedule`

### MemScoreHistory
* Tracks MemScore changes over time

---

# 7. 🛠️ Tech Stack

### Frontend
* React 19 + Vite 7
* Tailwind CSS 4
* Framer Motion (animations)
* React Router v6
* Lucide React (icons)

### Backend
* Node.js + Express 4
* Mongoose ODM (MongoDB)
* JWT authentication
* Multer (file uploads)
* Helmet.js (security)
* express-validator (input validation)

### Database
* MongoDB

---

# 8. 🎨 Design System

* **Dark theme only**: monochrome base with neon blue/green accents
* **Cyber-grid aesthetic**: terminal-inspired components
* **No scrollbars**: perfect viewport fit
* **Geometric precision**: sharp lines, no rounded elements
* **Framer Motion**: smooth transitions and micro-animations

---

# 9. 👤 User Flow

1. Sign up → JWT auth
2. MemScore evaluation (3 phases)
3. Dashboard with due topics
4. Add topics with difficulty/category
5. Review topics (SM-2 scheduling)
6. Chronicle calendar view
7. DocTags for attachments
8. Journal for daily logging
9. Focus Mode for timed study sessions
10. Analytics for progress tracking

---

# 10. 🚧 Roadmap (Not Yet Implemented)

> **Key insight**: The `RevisionHistory` and `SpacedRepetitionSchedule` models already exist
> with rich schemas but are not wired into the review flow. Connecting them unlocks
> most aspirational features without any ML infrastructure.

---

### Phase 2 — Wire Existing Infrastructure (Pure Logic)

Prerequisite for all subsequent phases.

* **Wire RevisionHistory**: Create a `RevisionHistory` record in `POST /api/topics/:id/review` with `timeOfDay`, `wasCorrect`, `quality`, `responseTime`, `studyDuration`
* **Wire SpacedRepetitionSchedule**: Create schedule entries when topics are created/reviewed, using `timeSlot`, `priority`, `cognitiveLoad`
* **ReviseBy (Deadline System)**: Add `deadlineDate` field to Topic. On review, if deadline is approaching, compress intervals. On creation, back-schedule reviews to finish before deadline
* **Focus Mode Enhancement**: Filter topics by category/subject, show only selected subset in Focus Mode timer view

---

### Phase 3 — Behavior Intelligence (Heuristics, No ML)

All features use MongoDB aggregation queries on `RevisionHistory` data. No Python, no ML training.

* **Schedule Learning**: Query `getPerformanceByTimeOfDay()` per user. Identify highest-accuracy time slots. Prefer scheduling reviews during those windows
* **Behavior Learning**: Track skip patterns (which topics get skipped, at what time). If a category is consistently skipped in evening, shift it to morning
* **Memory Decay Model**: Apply Ebbinghaus forgetting curve `R = e^(-t/S)` per topic, where `S` is derived from the topic's `easeFactor` and `averagePerformance`. Use retention rate to adjust intervals
* **Difficulty Learning**: Compare `quality` scores against declared `difficulty`. If user consistently scores 5 on difficulty-4 topics, suggest lowering effective difficulty. Weighted average over last N reviews
* **Adaptive Load**: Use `SpacedRepetitionSchedule.optimizeSchedule()` with `cognitiveLoad` and `priority` to balance daily workload. Respect `maxDailyItems` and difficulty thresholds
* **Hourly Smart Refresh**: Background interval (e.g., every hour) that re-checks overdue topics, adjusts `nextReviewDate` for flexible items, and shifts load from crowded days
* **Natural Language Schedule (Basic)**: Regex-based parser for common patterns ("College 9-4 weekdays", "Free weekends"). Maps to `user.preferences.availability` object with day/hour slots. No NLP needed for 80% of cases
* **Voice Journal**: Browser `WebSpeech API` (`SpeechRecognition`) — no backend ML. Speech → text → journal entry. Chrome supports this natively

---

### Phase 4 — ML Layer (Python Microservice)

Only features that genuinely require ML. Can be deferred without blocking Phases 2–3.

* **Journal Analysis (NLP)**: Sentiment extraction, topic clustering from free-text journal entries. Requires Python + NLP model
* **Advanced Pattern Detection**: Complex multi-variable behavior patterns (e.g., "user performs 40% better on topic X after studying topic Y"). Benefits from clustering/classification models

---

### Phase 5 — Production

* Comprehensive testing suite
* Performance optimizations (query indexing, caching)
* Security hardening
* Deployment configuration
* Documentation completion

---

# 11. Final Tagline

**Memora — Sets Your Memory in Motion**
