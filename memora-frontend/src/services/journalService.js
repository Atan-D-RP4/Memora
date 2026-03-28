class JournalService {
  constructor() {
    this.activities = [];
    this.settings = this.loadSettings();
    this.currentUserId = null;
    this.apiBase = import.meta.env.VITE_API_URL || "/api";
  }

  getAuthHeaders() {
    const token = localStorage.getItem("accessToken");
    return {
      "Content-Type": "application/json",
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
    };
  }

  _log(level, message, data = {}) {
    const entry = {
      ts: new Date().toISOString(),
      level,
      module: "journal-service",
      msg: message,
      ...(Object.keys(data).length > 0 ? { data } : {}),
    };
    const consoleFn = level === "error" ? console.error : level === "warn" ? console.warn : console.log;
    consoleFn(JSON.stringify(entry));

    const token = localStorage.getItem("accessToken");
    if (token) {
      fetch(`${this.apiBase}/logs`, {
        method: "POST",
        headers: this.getAuthHeaders(),
        body: JSON.stringify({ level, module: "journal-service", msg: message, data, source: "frontend" }),
      }).catch(() => {});
    }
  }

  // Set current user for user-specific storage
  setCurrentUser(userId) {
    this.currentUserId = userId;
    this.settings = this.loadSettings();
  }

  // Get user-specific localStorage key
  getUserStorageKey(key) {
    return this.currentUserId ? `${key}_${this.currentUserId}` : key;
  }

  loadSettings() {
    const key = this.getUserStorageKey("journalSettings");
    const saved = localStorage.getItem(key);
    const defaultSettings = {
      autoJournal: true, // Enable by default for better UX
      autoPush: false,
      githubRepo: "",
      githubToken: "",
      journalFormat: "markdown",
      dailyPushTime: "23:59",
    };

    return saved
      ? { ...defaultSettings, ...JSON.parse(saved) }
      : defaultSettings;
  }

  saveSettings(settings) {
    this.settings = settings;
    localStorage.setItem(
      this.getUserStorageKey("journalSettings"),
      JSON.stringify(settings),
    );
  }

  // Log different types of activities
  logTopicAdded(topic) {
    if (!this.currentUserId) {
      return;
    }

    this._log("info", "topic-added-logged", { title: topic.title, difficulty: topic.difficulty });
    this.addActivity(
      `📚 Added new topic: "${topic.title}" (Difficulty: ${topic.difficulty}/5)`,
    );
  }

  logTopicReviewed(topic, performance) {
    if (!this.currentUserId) {
      return;
    }

    const performanceText = performance === "easy"
      ? "✅ Easy"
      : performance === "good"
      ? "👍 Good"
      : performance === "hard"
      ? "😅 Hard"
      : "❌ Failed";

    const topicTitle = topic?.title || "Unknown Topic";
    const topicDesc = topic?.content
      ? ` (${topic.content.substring(0, 50)}${
        topic.content.length > 50 ? "..." : ""
      })`
      : "";

    this._log("info", "topic-reviewed-logged", { title: topicTitle, performance });
    this.addActivity(
      `🔄 Reviewed "${topicTitle}"${topicDesc} - ${performanceText}`,
    );
  }

  logTopicSkipped(topic) {
    const topicTitle = topic?.title || "Unknown Topic";
    const topicDesc = topic?.content
      ? ` (${topic.content.substring(0, 50)}${
        topic.content.length > 50 ? "..." : ""
      })`
      : "";

    this._log("info", "topic-skipped-logged", { title: topicTitle });
    this.addActivity(
      `⏭️ Skipped "${topicTitle}"${topicDesc} - Will review later`,
    );
  }

  logTopicEdited(originalTopic, updatedData) {
    const topicTitle = originalTopic?.title || updatedData?.title ||
      "Unknown Topic";
    const changes = [];

    if (originalTopic?.title !== updatedData?.title) {
      changes.push(
        `title: "${originalTopic?.title}" → "${updatedData?.title}"`,
      );
    }
    if (originalTopic?.difficulty !== updatedData?.difficulty) {
      changes.push(
        `difficulty: ${originalTopic?.difficulty} → ${updatedData?.difficulty}`,
      );
    }

    const changeText = changes.length > 0 ? ` (${changes.join(", ")})` : "";
    this._log("info", "topic-edited-logged", { title: topicTitle, changeCount: changes.length });
    this.addActivity(`✏️ Edited "${topicTitle}"${changeText}`);
  }

  logDailySessionStart() {
    const today = new Date().toISOString().split("T")[0];
    const sessionKey = `session_logged_${today}`;

    if (!localStorage.getItem(sessionKey)) {
      this._log("info", "daily-session-started", {});
      this.addActivity(`🌅 Started learning session`);
      localStorage.setItem(sessionKey, "true");
    }
  }

  logMemScoreEvaluation(results) {
    const score = results.overallScore || 0;
    this._log("info", "memscore-evaluation-logged", { score });
    this.addActivity(
      `🧠 Completed MemScore evaluation - Score: ${score.toFixed(1)}/10`,
    );
  }

  logFocusSession(duration, topicsStudied = []) {
    const minutes = Math.round(duration / 60000);
    let activity = `⏱️ Focus session: ${minutes} minutes`;

    if (topicsStudied.length > 0) {
      activity += ` (${topicsStudied.length} topics)`;
    }

    this._log("info", "focus-session-logged", { minutes, topicCount: topicsStudied.length });
    this.addActivity(activity);
  }

  logStudyStreak(_currentStreak, _isNewRecord = false) {
    void _isNewRecord;
    return;
  }

  logMemScoreUpdate(oldScore, newScore) {
    if (!this.settings.autoJournal) return;

    const change = newScore - oldScore;
    const changeText = change > 0 ? `+${change.toFixed(1)}` : change.toFixed(1);

    this.addActivity(
      `🧠 MemScore updated: ${oldScore.toFixed(1)} → ${
        newScore.toFixed(1)
      } (${changeText})`,
    );
  }

  addActivity(activityText) {
    if (!this.currentUserId) {
      console.warn("📝 Journal: No user set, cannot add activity");
      return;
    }

    const today = new Date().toISOString().split("T")[0];
    const timestamp = new Date().toLocaleTimeString("en-US", {
      hour: "2-digit",
      minute: "2-digit",
    });

    const activity = `[${timestamp}] ${activityText}`;

    const todayActivities = this.getTodayActivities();

    const isDuplicate = todayActivities.some((existingActivity) =>
      existingActivity.includes(activityText.substring(0, 50))
    );

    if (isDuplicate) {
      this._log("debug", "activity-duplicate-skipped", { activityText: activityText.substring(0, 50) });
      return;
    }

    this._log("debug", "activity-added", { activityText: activityText.substring(0, 80) });
    todayActivities.push(activity);

    localStorage.setItem(
      this.getUserStorageKey(`activities_${today}`),
      JSON.stringify(todayActivities),
    );

    if (this.settings.autoJournal) {
      this.updateJournalEntry();
    }
  }

  getTodayActivities() {
    const today = new Date().toISOString().split("T")[0];
    const saved = localStorage.getItem(
      this.getUserStorageKey(`activities_${today}`),
    );
    return saved ? JSON.parse(saved) : [];
  }

  updateJournalEntry() {
    if (!this.settings.autoJournal) {
      return;
    }

    const today = new Date().toISOString().split("T")[0];
    const activities = this.getTodayActivities();

    let journalEntry =
      localStorage.getItem(this.getUserStorageKey(`journal_${today}`)) ||
      this.generateInitialEntry();

    const activitiesSection = activities.length > 0
      ? activities.map((activity) => `- ${activity}`).join("\n")
      : "- No activities logged yet";

    journalEntry = journalEntry.replace(
      /## 🎯 Today's Activities[\s\S]*?(?=\n## |$)/,
      `## 🎯 Today's Activities\n${activitiesSection}\n`,
    );

    const topicCount =
      activities.filter((a) =>
        a.includes("📚 Added new topic") ||
        a.includes('🔄 Reviewed "') ||
        a.includes("Added new topic") ||
        a.includes('Reviewed "')
      ).length;
    const focusSessions =
      activities.filter((a) =>
        a.includes("⏱️ Focus session:") ||
        a.includes("Focus session:")
      ).length;
    const totalTime = this.calculateTotalStudyTime(activities);

    journalEntry = journalEntry.replace(
      /- \*\*Topics Reviewed\*\*: \d+/,
      `- **Topics Reviewed**: ${topicCount}`,
    );
    journalEntry = journalEntry.replace(
      /- \*\*Focus Sessions\*\*: \d+/,
      `- **Focus Sessions**: ${focusSessions}`,
    );
    journalEntry = journalEntry.replace(
      /- \*\*Total Study Time\*\*: \d+ minutes/,
      `- **Total Study Time**: ${totalTime} minutes`,
    );

    localStorage.setItem(
      this.getUserStorageKey(`journal_${today}`),
      journalEntry,
    );

    this._log("debug", "journal-entry-updated", { date: today, topicCount, focusSessions, totalTime });

    window.dispatchEvent(
      new CustomEvent("journalUpdated", {
        detail: { date: today, content: journalEntry },
      }),
    );

    this._syncJournalToBackend(today, journalEntry, activities).catch((error) => {
      this._log("warn", "journal-sync-failed", {
        error: error?.message || "Unknown sync error",
      });
    });
  }

  async _syncJournalToBackend(date, content, activities) {
    if (!this.currentUserId) return;
    try {
      await fetch(`${this.apiBase}/journal`, {
        method: "POST",
        headers: this.getAuthHeaders(),
        body: JSON.stringify({ date, content, activities }),
      });
    } catch (error) {
      this._log("warn", "journal-backend-sync-exception", {
        error: error?.message || "Unknown backend sync error",
      });
    }
  }

  calculateTotalStudyTime(activities) {
    let totalMinutes = 0;

    activities.forEach((activity) => {
      const match = activity.match(/Focus session: (\d+) minutes/);
      if (match) {
        totalMinutes += parseInt(match[1]);
      }
    });

    return totalMinutes;
  }

  generateInitialEntry() {
    const today = new Date();
    const dateStr = today.toLocaleDateString("en-US", {
      weekday: "long",
      year: "numeric",
      month: "long",
      day: "numeric",
    });

    return `# Learning Journal - ${dateStr}

## 📚 Study Summary
- **Topics Reviewed**: 0
- **Focus Sessions**: 0
- **Total Study Time**: 0 minutes

## 🎯 Today's Activities
- No activities logged yet

## 💭 Reflections
*What did I learn today?*


*What challenges did I face?*


*What will I focus on tomorrow?*


## 📊 Progress Notes
*Any insights about my learning patterns or memory retention?*


---
*Auto-generated by Memora Learning Journal*`;
  }

  // GitHub integration
  async pushToGitHub() {
    if (!this.settings.githubRepo || !this.settings.githubToken) {
      throw new Error("GitHub repository and token must be configured");
    }

    const today = new Date().toISOString().split("T")[0];
    const journalEntry = localStorage.getItem(
      this.getUserStorageKey(`journal_${today}`),
    );

    if (!journalEntry) {
      throw new Error("No journal entry found for today");
    }

    const fileName = `${today}.md`;
    const content = btoa(unescape(encodeURIComponent(journalEntry))); // Base64 encode

    try {
      // Check if file exists
      const checkResponse = await fetch(
        `https://api.github.com/repos/${this.settings.githubRepo}/contents/${fileName}`,
        {
          headers: {
            "Authorization": `token ${this.settings.githubToken}`,
            "Accept": "application/vnd.github.v3+json",
          },
        },
      );

      let sha = null;
      if (checkResponse.ok) {
        const fileData = await checkResponse.json();
        sha = fileData.sha;
      }

      // Create or update file
      const response = await fetch(
        `https://api.github.com/repos/${this.settings.githubRepo}/contents/${fileName}`,
        {
          method: "PUT",
          headers: {
            "Authorization": `token ${this.settings.githubToken}`,
            "Accept": "application/vnd.github.v3+json",
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            message: `Learning journal entry for ${today}`,
            content: content,
            ...(sha && { sha }),
          }),
        },
      );

      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.message || "Failed to push to GitHub");
      }

      return await response.json();
    } catch (error) {
      console.error("GitHub push error:", error);
      throw error;
    }
  }

  // Schedule daily push
  scheduleDailyPush() {
    if (!this.settings.autoPush) return;

    const now = new Date();
    const [hours, minutes] = this.settings.dailyPushTime.split(":");
    const pushTime = new Date();
    pushTime.setHours(parseInt(hours), parseInt(minutes), 0, 0);

    // If push time has passed today, schedule for tomorrow
    if (pushTime <= now) {
      pushTime.setDate(pushTime.getDate() + 1);
    }

    const timeUntilPush = pushTime.getTime() - now.getTime();

    setTimeout(async () => {
      try {
        await this.pushToGitHub();

        this.scheduleDailyPush();
      } catch (error) {
        console.error("Failed to push daily journal:", error);

        setTimeout(() => this.scheduleDailyPush(), 60 * 60 * 1000);
      }
    }, timeUntilPush);
  }

  // Initialize the service
  init() {
    if (this.settings.autoPush) {
      this.scheduleDailyPush();
    }
  }
}

// Create singleton instance
const journalService = new JournalService();

export default journalService;
