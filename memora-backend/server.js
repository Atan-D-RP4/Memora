const { app, connectDB } = require("./app");

const PORT = process.env.PORT || 3001;

connectDB().finally(() => {
  app.listen(PORT, () => {
    console.log(`🚀 Memora Backend Server running on port ${PORT}`);
    console.log(`🌐 Environment: ${process.env.NODE_ENV || "development"}`);
  });
});

module.exports = app;
