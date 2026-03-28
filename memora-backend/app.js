const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const helmet = require("helmet");
const rateLimit = require("express-rate-limit");
require("dotenv").config();

const app = express();

let isDbConnectInFlight = null;

const connectDB = async () => {
  if (mongoose.connection.readyState === 1) {
    return;
  }

  if (isDbConnectInFlight) {
    return isDbConnectInFlight;
  }

  isDbConnectInFlight = mongoose.connect(
    process.env.MONGODB_URI || "mongodb://localhost:27017/memora",
  )
    .then((conn) => {
      console.log(`✅ MongoDB Connected: ${conn.connection.host}`);
    })
    .catch((error) => {
      if (process.env.NODE_ENV === "production") {
        console.error("❌ MongoDB connection failed:", error.message);
        throw error;
      }

      console.warn(
        "⚠️  MongoDB connection failed. Running in development mode without database.",
      );
      console.warn(
        "To use full functionality, please start MongoDB or provide a valid MONGODB_URI",
      );
    })
    .finally(() => {
      isDbConnectInFlight = null;
    });

  return isDbConnectInFlight;
};

app.use(helmet());

if (process.env.NODE_ENV === "production") {
  const limiter = rateLimit({
    windowMs: 15 * 60 * 1000,
    max: 100,
    message: "Too many requests from this IP, please try again later.",
  });
  app.use(limiter);
}

app.use(cors({
  origin: [
    "http://localhost:5173",
    "https://lwj6kt2m-5173.inc1.devtunnels.ms",
    process.env.FRONTEND_URL,
  ].filter(Boolean),
  credentials: true,
  methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
  allowedHeaders: ["Content-Type", "Authorization"],
}));

app.use(express.json({ limit: "10mb" }));
app.use(express.urlencoded({ extended: true }));

app.use("/uploads", express.static("uploads"));

app.get("/", (req, res) => {
  res.json({
    message: "Memora Backend API",
    status: "running",
    endpoints: {
      health: "/api/health",
      auth: "/api/auth/*",
      user: "/api/user/*",
      topics: "/api/topics/*",
      doctags: "/api/doctags/*",
      journal: "/api/journal/*",
      logs: "/api/logs/*",
    },
  });
});

app.get("/api/health", (req, res) => {
  res.json({
    status: "OK",
    message: "Memora Backend API is running",
    timestamp: new Date().toISOString(),
  });
});

app.use("/api/auth", require("./routes/auth"));
app.use("/api/user", require("./routes/user"));
app.use("/api/topics", require("./routes/topics"));
app.use("/api/doctags", require("./routes/doctags"));
app.use("/api/journal", require("./routes/journal"));
app.use("/api/logs", require("./routes/logs"));

app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    message: "Something went wrong!",
    error: process.env.NODE_ENV === "development"
      ? err.message
      : "Internal server error",
  });
});

app.use("*", (req, res) => {
  res.status(404).json({ message: "Route not found" });
});

module.exports = { app, connectDB };
