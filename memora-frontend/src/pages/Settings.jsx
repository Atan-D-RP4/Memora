import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import {
  ArrowLeft,
  Bell,
  Brain,
  Clock,
  Moon,
  Palette,
  Save,
  Settings as SettingsIcon,
  Shield,
  Sliders,
  Zap,
} from "lucide-react";
import { useAuth } from "../contexts/AuthContext";
import Toast from "../components/Toast";
import apiService from "../services/api";

const TABS = [
  { id: "appearance", label: "Appearance", icon: Palette },
  { id: "learning", label: "Learning", icon: Brain },
  { id: "notifications", label: "Notifications", icon: Bell },
  { id: "focus", label: "Focus", icon: Clock },
  { id: "privacy", label: "Privacy", icon: Shield },
];

const Settings = () => {
  const navigate = useNavigate();
  const { user, updateUser } = useAuth();

  const [activeTab, setActiveTab] = useState("appearance");
  const [saving, setSaving] = useState(false);
  const [toast, setToast] = useState({ show: false, message: "", type: "success" });

  const [prefs, setPrefs] = useState({
    colorTheme: user?.preferences?.colorTheme || "monochrome",
    defaultDifficulty: user?.preferences?.defaultDifficulty || 3,
    retentionSpeed: user?.preferences?.retentionSpeed || "medium",
    memScoreRecalibrationFreq: user?.preferences?.memScoreRecalibrationFreq || 30,
    notificationsEnabled: false,
    focusDefaultMinutes: 25,
    focusMethod: "pomodoro",
  });

  const showToast = (message, type = "success") => {
    setToast({ show: true, message, type });
  };

  const handleSave = async () => {
    setSaving(true);
    try {
      const response = await apiService.updateUserProfile({ preferences: prefs });
      if (response.success) {
        updateUser({ ...user, preferences: prefs });
        showToast("Settings saved");
      } else {
        showToast(response.message || "Failed to save settings", "error");
      }
    } catch {
      showToast("Failed to save settings", "error");
    } finally {
      setSaving(false);
    }
  };

  const setPref = (key, value) => setPrefs((p) => ({ ...p, [key]: value }));

  return (
    <div className="min-h-screen bg-black text-white flex flex-col">
      <Toast
        show={toast.show}
        message={toast.message}
        type={toast.type}
        onClose={() => setToast((t) => ({ ...t, show: false }))}
      />

      <header className="border-b border-white/10 px-6 py-4 flex items-center gap-4">
        <button
          onClick={() => navigate(-1)}
          className="p-2 text-gray-400 hover:text-white transition-colors hover:bg-white/5 rounded"
        >
          <ArrowLeft size={18} />
        </button>
        <SettingsIcon size={18} className="text-blue-400" />
        <span className="font-mono text-sm tracking-widest uppercase text-gray-300">
          Settings
        </span>
        <div className="ml-auto">
          <button
            onClick={handleSave}
            disabled={saving}
            className="flex items-center gap-2 px-4 py-2 bg-blue-500/20 border border-blue-500/40 text-blue-300 hover:bg-blue-500/30 transition-colors text-sm font-mono disabled:opacity-50"
          >
            <Save size={14} />
            {saving ? "Saving..." : "Save"}
          </button>
        </div>
      </header>

      <div className="flex flex-1 overflow-hidden">
        <nav className="w-48 border-r border-white/10 p-4 flex flex-col gap-1 shrink-0">
          {TABS.map(({ id, label, icon: Icon }) => (
            <button
              key={id}
              onClick={() => setActiveTab(id)}
              className={`flex items-center gap-3 px-3 py-2 text-left text-sm font-mono transition-colors ${
                activeTab === id
                  ? "bg-blue-500/20 text-blue-300 border border-blue-500/30"
                  : "text-gray-400 hover:text-white hover:bg-white/5"
              }`}
            >
              <Icon size={14} />
              {label}
            </button>
          ))}
        </nav>

        <main className="flex-1 p-8 overflow-y-auto">
          {activeTab === "appearance" && (
            <section className="max-w-lg space-y-6">
              <h2 className="font-mono text-xs tracking-widest uppercase text-gray-500 border-b border-white/10 pb-2">
                Appearance
              </h2>

              <div className="space-y-2">
                <label className="block text-sm text-gray-400 font-mono">Color Theme</label>
                <div className="flex gap-3">
                  {["monochrome", "neon-blue", "neon-green"].map((theme) => (
                    <button
                      key={theme}
                      onClick={() => setPref("colorTheme", theme)}
                      className={`px-3 py-2 text-xs font-mono border transition-colors ${
                        prefs.colorTheme === theme
                          ? "border-blue-500 bg-blue-500/20 text-blue-300"
                          : "border-white/20 text-gray-400 hover:border-white/40"
                      }`}
                    >
                      {theme}
                    </button>
                  ))}
                </div>
              </div>
            </section>
          )}

          {activeTab === "learning" && (
            <section className="max-w-lg space-y-6">
              <h2 className="font-mono text-xs tracking-widest uppercase text-gray-500 border-b border-white/10 pb-2">
                Learning
              </h2>

              <div className="space-y-2">
                <label className="block text-sm text-gray-400 font-mono">
                  Default Difficulty (1–5)
                </label>
                <input
                  type="range"
                  min={1}
                  max={5}
                  value={prefs.defaultDifficulty}
                  onChange={(e) => setPref("defaultDifficulty", Number(e.target.value))}
                  className="w-full accent-blue-500"
                />
                <div className="text-xs text-gray-500 font-mono">
                  Current: {prefs.defaultDifficulty}
                </div>
              </div>

              <div className="space-y-2">
                <label className="block text-sm text-gray-400 font-mono">Retention Speed</label>
                <div className="flex gap-3">
                  {["fast", "medium", "slow"].map((speed) => (
                    <button
                      key={speed}
                      onClick={() => setPref("retentionSpeed", speed)}
                      className={`px-3 py-2 text-xs font-mono border transition-colors ${
                        prefs.retentionSpeed === speed
                          ? "border-blue-500 bg-blue-500/20 text-blue-300"
                          : "border-white/20 text-gray-400 hover:border-white/40"
                      }`}
                    >
                      {speed}
                    </button>
                  ))}
                </div>
              </div>

              <div className="space-y-2">
                <label className="block text-sm text-gray-400 font-mono">
                  MemScore Recalibration (days)
                </label>
                <input
                  type="number"
                  min={7}
                  max={365}
                  value={prefs.memScoreRecalibrationFreq}
                  onChange={(e) =>
                    setPref("memScoreRecalibrationFreq", Number(e.target.value))
                  }
                  className="w-32 bg-black border border-white/20 text-white px-3 py-2 text-sm font-mono focus:border-blue-500 focus:outline-none"
                />
              </div>
            </section>
          )}

          {activeTab === "notifications" && (
            <section className="max-w-lg space-y-6">
              <h2 className="font-mono text-xs tracking-widest uppercase text-gray-500 border-b border-white/10 pb-2">
                Notifications
              </h2>
              <div className="flex items-center justify-between">
                <span className="text-sm text-gray-400 font-mono">Enable notifications</span>
                <button
                  onClick={() => setPref("notificationsEnabled", !prefs.notificationsEnabled)}
                  className={`w-10 h-5 rounded-full transition-colors relative ${
                    prefs.notificationsEnabled ? "bg-blue-500" : "bg-white/20"
                  }`}
                >
                  <span
                    className={`absolute top-0.5 w-4 h-4 bg-white rounded-full transition-transform ${
                      prefs.notificationsEnabled ? "translate-x-5" : "translate-x-0.5"
                    }`}
                  />
                </button>
              </div>
              <p className="text-xs text-gray-600 font-mono">
                Browser notification support coming soon.
              </p>
            </section>
          )}

          {activeTab === "focus" && (
            <section className="max-w-lg space-y-6">
              <h2 className="font-mono text-xs tracking-widest uppercase text-gray-500 border-b border-white/10 pb-2">
                Focus Mode
              </h2>

              <div className="space-y-2">
                <label className="block text-sm text-gray-400 font-mono">
                  Default Session Length (minutes)
                </label>
                <input
                  type="number"
                  min={1}
                  max={180}
                  value={prefs.focusDefaultMinutes}
                  onChange={(e) =>
                    setPref("focusDefaultMinutes", Number(e.target.value))
                  }
                  className="w-32 bg-black border border-white/20 text-white px-3 py-2 text-sm font-mono focus:border-blue-500 focus:outline-none"
                />
              </div>

              <div className="space-y-2">
                <label className="block text-sm text-gray-400 font-mono">Default Method</label>
                <div className="flex gap-3">
                  {["pomodoro", "continuous"].map((method) => (
                    <button
                      key={method}
                      onClick={() => setPref("focusMethod", method)}
                      className={`px-3 py-2 text-xs font-mono border transition-colors ${
                        prefs.focusMethod === method
                          ? "border-blue-500 bg-blue-500/20 text-blue-300"
                          : "border-white/20 text-gray-400 hover:border-white/40"
                      }`}
                    >
                      {method}
                    </button>
                  ))}
                </div>
              </div>
            </section>
          )}

          {activeTab === "privacy" && (
            <section className="max-w-lg space-y-6">
              <h2 className="font-mono text-xs tracking-widest uppercase text-gray-500 border-b border-white/10 pb-2">
                Privacy
              </h2>
              <p className="text-sm text-gray-500 font-mono">
                All your data is stored privately and never shared. Local
                focus session history is stored only in your browser.
              </p>
              <p className="text-xs text-gray-600 font-mono">
                Data export and account deletion are available on the Profile page.
              </p>
            </section>
          )}
        </main>
      </div>
    </div>
  );
};

export default Settings;
