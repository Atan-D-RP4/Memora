#import "@preview/showybox:2.0.4": showybox

#import "@preview/tablex:0.0.9": colspanx, rowspanx, tablex
#let document-title = "Memora"
#let submission-details = [
  A Project report submitted in partial fulfillment of the requirements for the award of degree in
  *BACHELOR OF TECHNOLOGY* \
  *(COMPUTER SCIENCE AND ENGINEERING)*

  *SUBMITTED BY* \
  #table(
    columns: (auto, auto),
    align: left,
    [Registration number], [Name of the Student],
    [A22126510134], [Bheesetti Harsith Veera Charan],
    [A22126510144], [D. Chaitanya],
    [A22126510163], [M. Sai Teja],
    [A22126510193], [Venkata Vishaal Tirupalli],
    [A22126510194], [Wuna Akhilesh],
  )

  *UNDER THE GUIDANCE OF* \
  Dr. D. Naga Teja \
  Associate professor

  #box(width: 2.4in, height: 2.4in)[
    #image("./anits_logo.png", width: 2.4in, height: 2.4in)
  ]

  *DEPARTMENT OF COMPUTER SCIENCE AND ENGINEERING* \
  *ANIL NEERUKONDA INSTITUTE OF TECHNOLOGY AND SCIENCES (A+)* \
  SANGIVALASA, VISAKHAPATNAM – 531162 \
  July - 2025
]

#set document(title: document-title)
#set page(
  margin: (x: 1in, y: 1in),
  numbering: "i",
)

#set text(font: "Times New Roman", size: 12pt)
#set heading(numbering: "1.")
#set par(justify: true, leading: 1em)

#align(center)[
  #text(size: 16pt, weight: "bold")[#document-title]
  #v(1em)
  #submission-details
]

#pagebreak()

#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 2cm),
  numbering: "1",
)

#set text(
  font: "New Computer Modern",
  size: 11pt,
  lang: "en",
)

#set heading(numbering: "1.1")

#set par(
  justify: true,
  leading: 0.65em,
)

#show heading.where(level: 1): it => [
  #pagebreak(weak: true)
  #v(1em)
  #block(fill: rgb("#1f2937"), inset: 1em, radius: 0.5em, text(fill: white, weight: "bold", size: 1.2em)[#it])
  #v(1em)
]

#show heading.where(level: 2): it => [
  #v(0.8em)
  #text(fill: rgb("#374151"), weight: "bold", size: 1.1em)[#it]
  #v(0.5em)
]

#show heading.where(level: 3): it => [
  #v(0.6em)
  #text(fill: rgb("#4b5563"), weight: "bold")[#it]
  #v(0.3em)
]

#show raw.where(block: true): it => block(fill: rgb("#f3f4f6"), inset: 1em, radius: 0.3em, width: 100%, text(
  font: "JetBrainsMono NF",
  size: 9pt,
)[#it])

#show raw.where(block: false): it => box(fill: rgb("#e5e7eb"), inset: (x: 0.3em, y: 0.1em), radius: 0.2em, text(
  font: "JetBrainsMono NF",
  size: 9pt,
)[#it])

#align(center)[
  #v(2cm)
  #text(text(document-title), size: 2.5em, weight: "bold")

  #v(1cm)
  #text(size: 1.5em, style: "italic")[
    For Spaced Repetition Learning based on Ebbinghaus Forgetting Curve
  ]

  #v(2cm)
  #text(size: 1.2em)[
    Technical Documentation and Report
  ]

  #v(1cm)
  #text(size: 1em)[
    Version 1.0 • #datetime.today().display()
  ]

  #v(2cm)
  #text(size: 1em)[
    Learning Smarter • Retaining Longer • Performing Better
  ]
  #v(1em)
  #text(size: 1em)[
    Powered by Smart Repetition
  ]
]

#pagebreak()

#outline(depth: 2, indent: auto)

#pagebreak()

#heading(level: 1)[Introduction]

Memora is an advanced spaced repetition learning platform designed to optimize memory retention through scientifically-backed algorithms and personalized cognitive assessment. The system combines modern web technologies with proven learning methodologies to create an intelligent, adaptive learning environment that helps users retain information more effectively and study smarter.

The name "Memora" derives from the concept of "memory in motion," emphasizing the platform's dynamic approach to knowledge retention. Rather than static flashcards or passive review systems, Memora actively adapts to each user's cognitive profile and learning patterns, creating a personalized learning journey that maximizes retention while minimizing study time waste.

#heading(level: 2)[Motivation and Context]

Traditional learning methods often suffer from inefficient review schedules and lack of personalization. Research in cognitive science has consistently shown that spaced repetition—the practice of reviewing information at increasing intervals—is one of the most effective techniques for long-term memory retention. However, implementing this technique manually is cumbersome and error-prone.

The forgetting curve, first described by Hermann Ebbinghaus in 1885, demonstrates that memory retention decreases exponentially over time. Without reinforcement, newly learned information can be forgotten within days or even hours. Ebbinghaus's research showed that the rate of forgetting follows a predictable pattern, but strategic review at specific intervals can dramatically improve long-term retention.

Despite this well-established scientific foundation, most students and professionals still rely on inefficient study methods such as cramming, re-reading notes without strategic timing, or using generic study apps that don't account for individual differences. This disconnect between what cognitive science tells us works and what people actually do in practice represents a significant opportunity for technological intervention.

Memora addresses this challenge by automating the spaced repetition process while adding sophisticated cognitive assessment capabilities. The platform evaluates each user's learning profile through comprehensive testing, then adapts the review schedule based on individual performance patterns and cognitive strengths. By combining the SuperMemo SM-2 algorithm with modern web technologies and user-centered design, Memora makes evidence-based learning accessible and practical for everyday use.

#heading(level: 2)[Problem Statement]

Students and lifelong learners face several critical challenges in effective knowledge retention:

1. *Inefficient Review Scheduling*: Manual tracking of when to review topics leads to forgotten material or premature reviews. Users struggle to determine optimal review timing, often reviewing too early (wasting time) or too late (requiring complete relearning). Without algorithmic support, maintaining an effective spaced repetition schedule for multiple topics becomes overwhelming.

2. *One-Size-Fits-All Approaches*: Generic learning apps don't account for individual cognitive differences and learning patterns. A student with strong visual memory may have different optimal review intervals than one with stronger verbal processing. Current platforms apply the same scheduling algorithm to all users regardless of their cognitive profile, leading to suboptimal outcomes.

3. *Lack of Performance Insights*: Users cannot easily identify their cognitive strengths and areas needing improvement. Without baseline cognitive assessment, learners don't know whether poor performance stems from inadequate study time, ineffective study methods, or cognitive factors. This lack of insight prevents targeted improvement strategies.

4. *Poor Study Organization*: Difficulty managing multiple subjects, topics, and review schedules simultaneously. As the number of topics grows, manual scheduling becomes impractical. Users need intelligent load balancing to prevent overwhelming study days while ensuring consistent progress across all learning materials.

5. *Motivation Issues*: Without proper progress tracking and personalized feedback, learners often abandon study routines. The abstract nature of memory improvement makes it difficult to perceive progress, leading to decreased motivation over time. Gamification elements and visual progress indicators are needed to maintain long-term engagement.

6. *Information Overload*: In an era where information is abundant but attention is scarce, learners struggle to focus on what truly needs review. Smart filtering and prioritization based on actual forgetting patterns rather than arbitrary schedules is essential for efficient learning.

7. *Lack of Integration*: Existing solutions often separate cognitive assessment from learning content management, forcing users to maintain multiple tools and manually correlate their performance data with study materials.

#heading(level: 2)[Objectives]

The main objectives of this project are:

1. *Implement Intelligent Spaced Repetition*: Develop an enhanced SM-2 algorithm that adapts to individual learning patterns and performance. The system should automatically calculate optimal review intervals based on difficulty level, user performance, and cognitive profile. Implementation includes ease factor adjustments, interval calculations, and intelligent rescheduling to prevent crowded study days.

2. *Create Comprehensive Cognitive Assessment*: Design and implement a multi-faceted evaluation system (MemScore) that measures memory capacity, processing speed, and spatial reasoning. The assessment should be completable in 10-15 minutes while providing reliable indicators of cognitive strengths and learning capacity. Results should be quantified on a 0-100 scale and used to personalize the learning algorithm.

3. *Build Modern Web Interface*: Develop a responsive, cyber-themed user interface that provides an engaging and distraction-free learning experience. The interface should feature a dark-theme cyber-grid aesthetic with neon accents, smooth animations powered by Framer Motion, and responsive design optimized for both desktop and mobile devices. The design should minimize cognitive load while maximizing focus on learning content.

4. *Ensure Robust Data Management*: Implement secure user authentication with JWT tokens and refresh token rotation, comprehensive data persistence in MongoDB, and reliable performance tracking across all user interactions. The system should maintain data integrity while providing fast access to user profiles, topics, and performance metrics.

5. *Provide Actionable Insights*: Offer detailed analytics and progress tracking to help users understand their learning patterns and optimize study strategies. This includes visualization of retention rates, identification of difficult topics, tracking of study streaks, and personalized recommendations for improving learning efficiency.

6. *Enable Scalable Architecture*: Design the system with scalability in mind, using a modern MERN stack (MongoDB, Express.js, React, Node.js) that can handle growing user bases and expanding feature sets. The architecture should support future enhancements such as collaborative learning, mobile applications, and advanced analytics.

7. *Maintain Scientific Rigor*: Ground all learning algorithms and cognitive assessments in established cognitive psychology research. Ensure that the spaced repetition implementation faithfully represents the SM-2 algorithm while adding enhancements based on contemporary research in educational technology.

#pagebreak()

#heading(level: 1)[Literature Review]

The development of Memora is grounded in extensive research from cognitive psychology, educational technology, and computer science. This section examines the foundational theories and empirical studies that inform our approach.

#heading(level: 2)[Spaced Repetition Research]

Spaced repetition has been extensively studied since the pioneering work of Hermann Ebbinghaus in the 1880s. Ebbinghaus's forgetting curve demonstrates that memory retention decreases exponentially over time, but this decline can be significantly mitigated through strategically spaced reviews.

*Historical Foundation*:

Hermann Ebbinghaus's seminal work "Memory: A Contribution to Experimental Psychology" (1885) established the mathematical relationship between time and forgetting. Through rigorous self-experimentation with nonsense syllables, Ebbinghaus demonstrated that:

- Memory retention follows a logarithmic decay function
- The rate of forgetting is steepest immediately after learning
- Strategic review can counteract the forgetting curve
- Spaced practice is superior to massed practice for long-term retention

This foundational work established the theoretical basis for all modern spaced repetition systems.

*Key Findings from Literature*:

1. *Cepeda et al. (2006)*: Conducted a comprehensive meta-analysis of distributed practice effects, analyzing 317 experiments across 185 published studies. Their findings definitively showed that spaced practice consistently outperforms massed practice across various learning domains, retention intervals, and subject populations. The optimal spacing gap depends on the desired retention interval, following an approximate ratio of 10-20% of the retention period.

2. *SuperMemo Research*: The SM-2 algorithm, developed by Dr. Piotr Wozniak in 1988, represents a practical implementation of spaced repetition principles. Wozniak's research at the University of Technology in Poznan, Poland, led to the creation of SuperMemo software, which has been validated through decades of use by millions of learners. The algorithm's success lies in its mathematical approach to modeling forgetting curves and optimizing review intervals through an ease factor that adapts to individual item difficulty.

3. *Modern Adaptations*: Contemporary research has focused on personalizing spacing algorithms to account for individual differences. Studies by Lindsey et al. (2014) demonstrated that adaptive algorithms that consider individual learner characteristics outperform fixed-interval approaches. Research in machine learning applications to spaced repetition (Reddy et al., 2016) has shown promise in further optimizing review schedules through predictive modeling.

4. *Cognitive Load Theory*: Work by Sweller (1988, 2011) on cognitive load theory provides additional context for why spaced repetition works. By distributing cognitive load over time and reviewing material when it's partially forgotten, spaced repetition systems maintain optimal cognitive load levels that promote deep learning without overwhelming working memory.

#heading(level: 2)[Cognitive Assessment Frameworks]

Our MemScore evaluation system draws inspiration from established cognitive testing methodologies used in neuropsychology and educational assessment.

*Memory Assessment*:

Working memory assessment has a rich history in cognitive psychology, dating back to the work of Baddeley and Hitch (1974) on the multi-component model of working memory. Our card-matching paradigm is based on similar tasks used in the Wechsler Memory Scale and other standardized cognitive assessments. Research shows that working memory capacity is a strong predictor of learning ability and academic performance (Alloway & Alloway, 2010).

The emoji-based matching game in Memora adapts these principles for web-based delivery while maintaining psychological validity. The 10-second preview phase engages encoding processes, while the matching phase tests retrieval and recognition memory.

*Spatial Memory*:

The tile recall test is inspired by Corsi block-tapping tasks, first developed by Corsi (1972) for assessing visuospatial working memory. This type of assessment has been validated extensively in neuropsychological research and is known to engage different cognitive processes than verbal memory tasks.

Our progressive difficulty approach (3→5→7→9→11 tiles) allows for assessment across a wide range of spatial memory capacity, from typical adult performance (around 7±2 items, consistent with Miller's "magical number seven") to exceptional performance levels.

*Processing Speed*:

Timed arithmetic operations reflect established measures of cognitive efficiency used in standardized tests such as the Wechsler Adult Intelligence Scale (WAIS) and the Woodcock-Johnson Tests of Cognitive Abilities. Processing speed has been shown to correlate with overall cognitive ability and learning efficiency (Kail & Salthouse, 1994).

The 30-second rapid-fire format creates time pressure that reveals true processing capacity rather than problem-solving ability, making it suitable for quick cognitive screening.

*Psychometric Considerations*:

While Memora's MemScore is not intended as a clinical assessment tool, it follows established psychometric principles:
- Multiple cognitive domains measured independently
- Quantified scoring on a normalized scale (0-100)
- Reproducible procedures for test administration
- Clear scoring algorithms without subjective judgment

#heading(level: 2)[User Interface and Learning UX]

Research in human-computer interaction for educational technology emphasizes several key principles implemented in Memora:

1. *Minimal Distraction*: Studies show that visual clutter increases cognitive load and reduces learning efficiency (Sweller, 2011). The principle of split-attention effect suggests that learners perform better when related information is integrated rather than separated. Memora's cyber-grid design with dark theme minimizes visual noise while maintaining professional aesthetics. The decision to eliminate scrollbars and design for perfect viewport fit reduces unnecessary interface elements that could distract from learning content.

2. *Gamification Elements*: Research by Deterding et al. (2011) on gamification in education demonstrates that game-like elements can increase motivation and engagement without undermining learning effectiveness. Progress tracking, achievement streaks, and visual feedback have been shown to improve long-term usage and learning outcomes (Hamari et al., 2014). Memora implements evidence-based gamification through:
   - Study streak tracking for habit formation
   - Visual progress indicators for motivation
   - Performance metrics that provide meaningful feedback
   - Achievement systems that encourage consistent practice

3. *Personalization*: Adaptive interfaces that respond to user preferences and performance patterns significantly improve long-term usage and learning outcomes (Park & Choi, 2014). Research in adaptive educational systems shows that learners who receive personalized content and pacing achieve better outcomes than those using fixed approaches (Vandewaetere et al., 2011).

4. *Cognitive Affordances*: Norman's (1988) concept of affordances in design is particularly relevant for educational interfaces. Interface elements should clearly communicate their function and relationship to learning goals. Memora's topic cards, review buttons, and progress indicators are designed with clear visual hierarchies that guide user actions.

5. *Feedback Timing*: Research on feedback in learning (Hattie & Timperley, 2007) indicates that immediate feedback is generally superior to delayed feedback for procedural learning. Memora provides instant feedback after topic reviews and cognitive assessments to reinforce learning behaviors.

#heading(level: 2)[Technical Implementation Considerations]

The technical architecture of Memora reflects current best practices in web application development:

*MERN Stack*: The combination of MongoDB, Express.js, React, and Node.js represents a modern, JavaScript-based full-stack approach that has gained widespread adoption for educational platforms. This stack provides:
- Unified language across frontend and backend (JavaScript)
- JSON-native data storage matching application data structures
- Component-based UI development for maintainability
- Scalable architecture suitable for growing user bases

*Real-time Updates*: Modern web technologies enable instant feedback and progressive enhancement of the learning experience. Research shows that system responsiveness significantly impacts user satisfaction and learning effectiveness (Nielsen, 1993).

*Security and Privacy*: Implementation of JWT authentication and secure data handling aligns with educational data privacy standards such as FERPA (Family Educational Rights and Privacy Act) in the United States and GDPR (General Data Protection Regulation) in Europe. Educational platforms must maintain high security standards due to the sensitive nature of student data.

*Database Design*: NoSQL databases like MongoDB offer flexibility for educational applications where data structures may evolve as features are added. The document-oriented model aligns well with object-oriented application design, reducing impedance mismatch between application code and data storage.

*API Architecture*: RESTful API design provides a clear, standardized interface between frontend and backend, facilitating future expansion to mobile applications or third-party integrations.

This literature review demonstrates that Memora's approach is well-supported by empirical research and established best practices in educational technology, cognitive psychology, and software engineering. The platform synthesizes insights from multiple disciplines to create a comprehensive learning solution grounded in scientific evidence.

#pagebreak()

#heading(level: 1)[System Design]

#heading(level: 2)[System Architecture]

Memora follows a modern full-stack architecture with clear separation of concerns between frontend and backend components. The system is designed for scalability, maintainability, and optimal performance.

*Architecture Overview*:

The system implements a three-tier architecture pattern that separates presentation, business logic, and data management into distinct layers. This separation provides several advantages:

- *Independent Scaling*: Frontend and backend can be scaled independently based on demand
- *Technology Flexibility*: Each layer can use the most appropriate technologies without constraints from other layers
- *Maintainability*: Changes to one layer have minimal impact on others, reducing coupling
- *Development Efficiency*: Teams can work on different layers simultaneously

*Frontend Layer*:

React-based single-page application (SPA) built with Vite for optimal development experience and build performance. The frontend handles all user interface logic, state management, and client-side routing. Key characteristics include:

- Component-based architecture promoting reusability and maintainability
- Tailwind CSS utility-first styling for rapid UI development
- Framer Motion for smooth, performant animations
- React Context API for global state management (authentication, timer sessions)
- React Router for client-side navigation without page reloads
- Responsive design adapting seamlessly from mobile to desktop viewports

*Backend Layer*:

RESTful API server built with Express.js and Node.js, providing secure endpoints for data management, user authentication, and business logic implementation. The backend serves as the single source of truth for application data and enforces business rules. Architecture features:

- Express.js middleware chain for request processing (authentication, validation, error handling)
- Modular route organization by feature (auth, user, topics, doctags, journal)
- JWT-based stateless authentication enabling horizontal scaling
- Input validation using express-validator for security and data integrity
- Helmet.js security headers for protection against common web vulnerabilities
- CORS configuration for controlled cross-origin access

*Database Layer*:

MongoDB with Mongoose ODM provides flexible, schema-based data storage and efficient querying of user data, topics, and performance metrics. Key aspects:

- Document-oriented storage matching JavaScript object structures
- Mongoose schemas providing validation and type safety at the database level
- Indexed fields optimizing common query patterns (user lookups, review date sorting)
- Embedded documents for related data reducing join operations
- Atomic operations for transactional updates of spaced repetition state

*Communication Layer*:

JWT-based authentication with refresh token rotation ensures secure, stateless communication between frontend and backend:

- Access tokens (15-minute expiry) for API authorization
- Refresh tokens (7-day expiry) for obtaining new access tokens
- Token rotation on refresh for security
- Automatic token refresh in ApiService for seamless user experience
- User-specific localStorage cleanup on logout preventing data leakage

#let Modules() = {
  box(width: 100%)[

    #align(center)[

      #text(16pt, weight: "bold")[System Components]
    ]
    #grid(
      columns: (1fr, 1fr, 1fr),
      rows: (auto, auto, auto),
      gutter: 10pt,
      align: center,
      [
        #box(fill: rgb("#f3f4f6"), inset: 1em, radius: 0.3em)[
          #text(weight: "bold")[Frontend Module]
          #linebreak()
          • React 19.1.0
          #linebreak()
          • Vite 7.0.4
          #linebreak()
          • Tailwind CSS
          #linebreak()
          • Framer Motion
          #linebreak()
          • React Router
        ]
      ],
      [
        #box(fill: rgb("#f3f4f6"), inset: 1em, radius: 0.3em)[
          #text(weight: "bold")[Backend Module]
          #linebreak()
          • Express.js 4.18.2
          #linebreak()
          • MongoDB + Mongoose
          #linebreak()
          • JWT Authentication
          #linebreak()
          • bcrypt Security
          #linebreak()
          • Multer File Uploads
        ]
      ],
      [
        #box(fill: rgb("#f3f4f6"), inset: 1em, radius: 0.3em)[
          #text(weight: "bold")[Core Features]
          #linebreak()
          • Spaced Repetition
          #linebreak()
          • MemScore Assessment
          #linebreak()
          • User Management
          #linebreak()
          • Performance Analytics
          #linebreak()
          • File Attachments
        ]
      ],
      [
        #box(fill: rgb("#f3f4f6"), inset: 1em, radius: 0.3em)[
          #text(weight: "bold")[Security Layer]
          #linebreak()
          • JWT Token Rotation
          #linebreak()
          • Password Hashing
          #linebreak()
          • Input Validation
          #linebreak()
          • CORS Configuration
          #linebreak()
          • Helmet.js Headers
        ]
      ],
      [
        #box(fill: rgb("#f3f4f6"), inset: 1em, radius: 0.3em)[
          #text(weight: "bold")[Data Management]
          #linebreak()
          • Topic CRUD Operations
          #linebreak()
          • Review Scheduling
          #linebreak()
          • Performance Tracking
          #linebreak()
          • User Preferences
          #linebreak()
          • Study Statistics
        ]
      ],
      [
        #box(fill: rgb("#f3f4f6"), inset: 1em, radius: 0.3em)[
          #text(weight: "bold")[UI/UX System]
          #linebreak()
          • Cyber-Grid Theme
          #linebreak()
          • Responsive Design
          #linebreak()
          • Motion Animations
          #linebreak()
          • Component Library
          #linebreak()
          • Interactive Backgrounds
        ]
      ]
    )
  ]
}
#Modules()

#heading(level: 2)[Database Schema Design]

The database schema is designed to efficiently store user information, learning materials, and performance metrics while supporting complex queries for the spaced repetition algorithm.

*User Collection*:

The User collection stores authentication credentials, cognitive assessment results, preferences, and study statistics. Key fields include:

- *Authentication*: username, email, hashed password (bcrypt with 12 salt rounds)
- *Cognitive Profile*: memScore (0-100), hasCompletedEvaluation, evaluationResults (memoryGame, tileRecall, processingSpeed scores)
- *Preferences*: colorTheme, defaultDifficulty, retentionSpeed, memScoreRecalibrationFreq
- *Study Statistics*: currentStreak, longestStreak, totalStudyDays, lastStudyDate
- *Session Management*: refreshTokens array with token and expiration date
- *Timestamps*: createdAt, updatedAt (automatic via Mongoose)

*Topic Collection*:

The Topic collection is the core of the spaced repetition system, containing learning materials and scheduling metadata:

- *Content*: title (max 200 chars), content (max 10,000 chars), difficulty (1-5 scale)
- *Organization*: category, tags array for filtering and search
- *Spaced Repetition Fields*: easeFactor (default 2.5), interval (days), repetitions, nextReviewDate, isLearning flag
- *Performance Tracking*: reviewCount, averagePerformance (0-1 scale), lastReviewed timestamp
- *Attachments*: embedded documents with filename, mimetype, size, URL
- *External Links*: array of objects with title, URL, type, description
- *Ownership*: userId reference to User collection

*Revision History Collection*:

Tracks detailed information about each review session:

- *References*: userId and topicId for relationship tracking
- *Timing*: revisionDate, scheduledFor, actualRevision, wasOnTime flag
- *Performance*: performanceRating (1-5), timeSpent (minutes)
- *Notes*: optional user notes about the review session

*Spaced Repetition Schedule Collection*:

Maintains the current state of the SM-2 algorithm for each topic:

- *References*: userId and topicId
- *Algorithm State*: currentInterval, easeFactor, repetitions, nextReview
- *Status*: isActive flag for paused topics
- *Timestamps*: createdAt, updatedAt

*Indexing Strategy*:

To optimize query performance, strategic indexes are created on:
- User: `{ email: 1 }`, `{ username: 1 }` for authentication
- Topic: `{ userId: 1, createdAt: -1 }` for user topic lists
- Topic: `{ userId: 1, nextReviewDate: 1 }` for due topics query
- Topic: `{ title: 'text', content: 'text' }` for full-text search
- RevisionHistory: `{ userId: 1, topicId: 1, revisionDate: -1 }` for history queries

#heading(level: 2)[Data Flow]

Memora's data flow follows a clear, secure pattern from user interaction through API processing to database storage and back.

*Authentication Flow*:

1. User submits credentials via login form
2. Frontend validates input format
3. ApiService sends POST request to `/api/auth/login`
4. Backend validates credentials, bcrypt compares hashed password
5. On success, server generates JWT access token (15 min) and refresh token (7 days)
6. Tokens returned to client and stored in localStorage
7. AuthContext updates with user data
8. Future API requests include access token in Authorization header
9. When access token expires, ApiService automatically uses refresh token to obtain new access token
10. On logout, backend invalidates refresh token and frontend clears localStorage

*Topic Creation Flow*:

1. User fills out topic creation form
2. Frontend validates required fields (title, content, difficulty)
3. ApiService sends POST request to `/api/topics` with topic data
4. Backend auth middleware verifies JWT token
5. Express-validator validates input constraints
6. Topic model creates new document with:
   - User-provided content fields
   - Initial spaced repetition values (easeFactor: 2.5, interval: 1, repetitions: 0)
   - nextReviewDate calculated based on difficulty
7. Document saved to MongoDB
8. Success response with created topic returned to frontend
9. Frontend updates local state and UI displays new topic

*Review Submission Flow*:

1. User completes topic review and rates performance (1-5)
2. Frontend sends POST to `/api/topics/:id/review` with quality rating
3. Backend retrieves topic from database
4. SM-2 algorithm method updates:
   - Increments reviewCount
   - Updates lastReviewed timestamp
   - Recalculates easeFactor based on quality rating
   - Computes next interval using enhanced SM-2 formula
   - Sets nextReviewDate = now + interval days
   - Updates averagePerformance running average
5. Updated topic saved to database
6. Revision history record created
7. Response returns updated topic and next review date
8. Frontend updates UI, showing next review date and statistics

*MemScore Evaluation Flow*:

1. User completes all three MemScore tests sequentially
2. Frontend calculates scores locally:
   - Memory Game: `max(0, 10 - wrongAttempts)`
   - Tile Recall: `2 points per correct round - 0.5 per mistake`
   - Processing Speed: `(correct / total) × 10`
   - Overall: `average of three scores`
3. Results posted to `/api/user/evaluation`
4. Backend validates score ranges (0-10 for each test)
5. User document updated with:
   - memScore = overallScore (scaled to 0-100)
   - evaluationResults object with all scores
   - hasCompletedEvaluation = true
   - lastMemScoreUpdate = current timestamp
6. Success response confirms save
7. Frontend updates AuthContext with new memScore
8. Dashboard displays updated cognitive profile

*Crowding Prevention Flow*:

1. User requests crowding prevention or system runs automatically
2. Backend queries topics for next 14 days grouped by date
3. For each day, calculate difficulty-weighted topic count
4. Identify days exceeding threshold (adjusted by average difficulty)
5. For crowded days, select topics for redistribution (prioritizing high difficulty)
6. Find alternative dates within ±3 to +7 day range with available capacity
7. Update nextReviewDate for redistributed topics
8. Increment rescheduleCount for tracking
9. Return updated schedule to frontend
10. UI displays notification of schedule optimization

#heading(level: 2)[API Endpoint Specifications]

The RESTful API follows standard HTTP conventions with JSON request/response bodies.

*Authentication Endpoints* (`/api/auth/`):

- `POST /register`: Create new user account
  - Request: `{ username, email, password }`
  - Validation: username 3-30 chars alphanumeric, email format, password min 8 chars with mixed case and numbers
  - Response: `{ success, message, data: { userId, username, email } }`

- `POST /login`: Authenticate user
  - Request: `{ email, password }`
  - Response: `{ success, data: { user, accessToken, refreshToken } }`

- `POST /logout`: Invalidate refresh token
  - Request: `{ refreshToken }`
  - Response: `{ success, message, data: null }`
