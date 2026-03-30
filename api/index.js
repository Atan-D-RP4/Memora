const { app, connectDB } = require("../memora-backend/app");

let connectionPromise = null;

const ensureConnection = async () => {
  if (connectionPromise) {
    return connectionPromise;
  }

  connectionPromise = connectDB().finally(() => {
    connectionPromise = null;
  });

  return connectionPromise;
};

app.use(async (req, res, next) => {
  try {
    await ensureConnection();
    next();
  } catch (error) {
    console.error("Database connection error:", error);
    res.status(503).json({
      success: false,
      message: "Database connection failed. Please try again.",
    });
  }
});

module.exports = app;
