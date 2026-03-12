const express = require("express");
const Log = require("../models/Log");
const { authenticateToken } = require("../middleware/auth");

const router = express.Router();

router.get("/", authenticateToken, async (req, res) => {
  try {
    const { level, module: mod, limit = 100, page = 1 } = req.query;

    const query = {};

    if (process.env.NODE_ENV !== "development") {
      query.userId = req.user.id;
    }

    if (level) query.level = level;
    if (mod) query.module = mod;

    const logs = await Log.find(query)
      .sort({ createdAt: -1 })
      .limit(parseInt(limit))
      .skip((parseInt(page) - 1) * parseInt(limit))
      .lean();

    const total = await Log.countDocuments(query);

    res.json({
      success: true,
      logs,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total,
        pages: Math.ceil(total / parseInt(limit)),
      },
    });
  } catch (error) {
    console.error("Get logs error:", error);
    res.status(500).json({
      success: false,
      message: "Failed to get logs",
    });
  }
});

router.post("/", authenticateToken, async (req, res) => {
  try {
    const { level = "info", module: mod = "frontend", msg, data } = req.body;

    if (!msg) {
      return res.status(400).json({
        success: false,
        message: "Log message is required",
      });
    }

    const validLevels = ["debug", "info", "warn", "error"];
    const safeLevel = validLevels.includes(level) ? level : "info";

    await Log.create({
      level: safeLevel,
      module: mod,
      message: msg,
      data: data || null,
      userId: req.user.id,
      source: "frontend",
    });

    res.status(201).json({ success: true });
  } catch (error) {
    console.error("Create log error:", error);
    res.status(500).json({
      success: false,
      message: "Failed to create log",
    });
  }
});

module.exports = router;
