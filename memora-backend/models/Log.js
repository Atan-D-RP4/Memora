const mongoose = require("mongoose");

const logSchema = new mongoose.Schema(
  {
    level: {
      type: String,
      enum: ["debug", "info", "warn", "error"],
      required: true,
      index: true,
    },
    module: {
      type: String,
      required: true,
      trim: true,
      index: true,
    },
    message: {
      type: String,
      required: true,
      trim: true,
    },
    data: {
      type: mongoose.Schema.Types.Mixed,
      default: null,
    },
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      default: null,
      index: true,
    },
    source: {
      type: String,
      enum: ["backend", "frontend"],
      default: "backend",
    },
  },
  {
    timestamps: true,
  },
);

// Compound indexes for common query patterns
logSchema.index({ level: 1, createdAt: -1 });
logSchema.index({ module: 1, createdAt: -1 });
logSchema.index({ userId: 1, createdAt: -1 });

// TTL index: auto-delete logs older than 30 days
logSchema.index({ createdAt: 1 }, { expireAfterSeconds: 30 * 24 * 60 * 60 });

module.exports = mongoose.model("Log", logSchema);
