const write = (level, moduleName, message, data = {}, userId = null) => {
  const entry = {
    ts: new Date().toISOString(),
    level,
    module: moduleName,
    msg: message,
    ...(Object.keys(data).length > 0 ? { data } : {}),
    ...(userId ? { userId: String(userId) } : {}),
  };

  if (level === "debug" && process.env.NODE_ENV === "production") {
  } else if (level === "error") {
    console.error(JSON.stringify(entry));
  } else if (level === "warn") {
    console.warn(JSON.stringify(entry));
  } else {
    console.log(JSON.stringify(entry));
  }

  try {
    const Log = require("../models/Log");
    Log.create({
      level,
      module: moduleName,
      message,
      data: Object.keys(data).length > 0 ? data : null,
      userId: userId || null,
      source: "backend",
    }).catch(() => {});
  } catch (_) {
  }
};

const createLogger = (moduleName) => ({
  debug: (message, data, userId) => write("debug", moduleName, message, data || {}, userId),
  info:  (message, data, userId) => write("info",  moduleName, message, data || {}, userId),
  warn:  (message, data, userId) => write("warn",  moduleName, message, data || {}, userId),
  error: (message, data, userId) => write("error", moduleName, message, data || {}, userId),
});

module.exports = createLogger;
