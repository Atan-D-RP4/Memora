const mongoose = require("mongoose");
require("dotenv").config();

const User = require("../models/User");
const Topic = require("../models/Topic");
const Journal = require("../models/Journal");
const RevisionHistory = require("../models/RevisionHistory");

const MONGODB_URI = process.env.MONGODB_URI || "mongodb://localhost:27017/memora";

async function connect() {
  await mongoose.connect(MONGODB_URI);
}

function daysFromNow(days) {
  const d = new Date();
  d.setDate(d.getDate() + days);
  return d;
}

async function createDemoUser() {
  const demoEmail = "demo@memora.local";

  let user = await User.findOne({ email: demoEmail });
  if (user) {
    console.log(`Found existing demo user: ${demoEmail}`);
    return user;
  }

  const demo = new User({
    username: "demo_user",
    email: demoEmail,
    password: "demo12345",
    memScore: 7,
    hasCompletedEvaluation: true,
    evaluationResults: {
      memoryGame: 8,
      tileRecall: 7,
      processingSpeed: 6,
      overallScore: 7,
      completedAt: new Date(),
    },
    preferences: {
      colorTheme: "neon-blue",
      defaultDifficulty: 3,
      retentionSpeed: "medium",
      memScoreRecalibrationFreq: 14,
    },
    currentStreak: 3,
    longestStreak: 10,
    totalStudyDays: 25,
    lastStudyDate: new Date(),
  });

  user = await demo.save();
  console.log(`Created demo user: ${user.email} (password: demo12345)`);
  return user;
}

async function createDemoTopics(user) {
  const existing = await Topic.find({ userId: user._id });
  if (existing && existing.length > 0) {
    console.log(`User already has ${existing.length} topics — skipping topic creation.`);
    return existing;
  }

  const demoTopics = [
    {
      title: "JavaScript Promises & Async/Await",
      content: "Understanding async programming, promise chaining, error handling, and parallel execution.",
      difficulty: 3,
      category: "Technology",
      tags: ["javascript", "async", "promises"],
      nextReviewDate: daysFromNow(-1), // overdue
    },
    {
      title: "Calculus: Integration by Parts",
      content: "Integration by parts formula and worked examples with trig and log functions.",
      difficulty: 4,
      category: "Mathematics",
      tags: ["calculus", "integration"],
      nextReviewDate: daysFromNow(0), // due today
    },
    {
      title: "Spanish: Business Vocabulary",
      content: "Key phrases and vocabulary for meetings, finance, and negotiations in Spanish.",
      difficulty: 2,
      category: "Language",
      tags: ["spanish", "vocabulary"],
      nextReviewDate: daysFromNow(2),
    },
    {
      title: "World War II: Major Turning Points",
      content: "Brief summary of major battles, political moves, and timelines that shaped WWII.",
      difficulty: 2,
      category: "History",
      tags: ["history", "wwii"],
      nextReviewDate: daysFromNow(5),
    },
    {
      title: "Organic Chemistry: Alkenes Reactions",
      content: "Addition reactions, polymerization, and stereochemistry of alkenes and alkynes.",
      difficulty: 5,
      category: "Science",
      tags: ["chemistry", "organic"],
      nextReviewDate: daysFromNow(10),
    },
    {
      title: "Productivity: Pomodoro Technique",
      content: "How to use Pomodoro for focused study sessions with planning and review steps.",
      difficulty: 1,
      category: "Business",
      tags: ["productivity", "study"],
      nextReviewDate: daysFromNow(1),
    },
  ];

  const created = [];
  for (const t of demoTopics) {
    const topic = new Topic({
      ...t,
      userId: user._id,
      learnedDate: new Date(),
      easeFactor: 2.5,
      interval: 1,
      repetitions: Math.floor(Math.random() * 3),
      isLearning: Math.random() > 0.5,
    });

    await topic.save();
    console.log(`Added topic: ${topic.title} (nextReview: ${topic.nextReviewDate.toISOString().split('T')[0]})`);
    created.push(topic);
  }

  return created;
}

async function createDemoJournals(user) {
  const existing = await Journal.find({ userId: user._id });
  if (existing && existing.length > 0) {
    console.log(`User already has ${existing.length} journal entries — skipping journals.`);
    return existing;
  }

  const moods = ["good", "neutral", "excellent", "good", "poor", "good", "neutral"];
  const created = [];
  for (let i = 0; i < 7; i++) {
    const date = daysFromNow(-i);
    const entry = new Journal({
      userId: user._id,
      date,
      content: `Day ${i + 1}: Quick study summary. Practiced topics and reviewed schedule. Felt ${moods[i]}.`,
      mood: moods[i],
      tags: ["study", "demo"],
    });

    await entry.save();
    created.push(entry);
    console.log(`Added journal: ${entry.dateString} (${entry.mood})`);
  }

  return created;
}

async function createDemoRevisions(user, topics) {
  const existing = await RevisionHistory.find({ userId: user._id });
  if (existing && existing.length > 0) {
    console.log(`User already has ${existing.length} revision records — skipping revisions.`);
    return existing;
  }

  const created = [];

  for (let i = 0; i < Math.min(12, topics.length * 2); i++) {
    const topic = topics[i % topics.length];
    const quality = Math.floor(Math.random() * 5) + 1; // 1-5
    const wasCorrect = quality >= 3;
    const beforeInterval = Math.max(1, topic.interval - 1);
    const afterInterval = wasCorrect ? Math.round(beforeInterval * (topic.easeFactor || 2.5)) : 1;

    const rev = new RevisionHistory({
      userId: user._id,
      topicId: topic._id,
      sessionId: `demo-${Date.now()}-${i}`,
      quality,
      responseTime: Math.floor(Math.random() * 5000) + 200,
      difficulty: topic.difficulty,
      wasCorrect,
      intervalBefore: beforeInterval,
      intervalAfter: afterInterval,
      easeFactorBefore: topic.easeFactor || 2.5,
      easeFactorAfter: topic.easeFactor || 2.5,
      repetitionsBefore: topic.repetitions || 0,
      repetitionsAfter: (topic.repetitions || 0) + (wasCorrect ? 1 : 0),
      streakBefore: user.currentStreak,
      streakAfter: user.currentStreak + (wasCorrect ? 1 : 0),
      deviceType: i % 2 === 0 ? "desktop" : "mobile",
      timeOfDay: i % 3 === 0 ? "morning" : "evening",
      studyDuration: Math.floor(Math.random() * 20) + 5,
      notes: wasCorrect ? "Quick recall" : "Need to review again",
    });

    await rev.save();
    created.push(rev);
  }

  console.log(`Added ${created.length} demo revision records.`);
  return created;
}

async function run() {
  try {
    console.log("Connecting to database...", MONGODB_URI);
    await connect();

    const user = await createDemoUser();
    const topics = await createDemoTopics(user);
    await createDemoJournals(user);
    await createDemoRevisions(user, topics);

    console.log("✅ Demo data seeded successfully.");
    process.exit(0);
  } catch (err) {
    console.error("❌ Error seeding demo data:", err);
    process.exit(1);
  }
}

run();
