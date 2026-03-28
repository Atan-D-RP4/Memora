import { describe, test, expect, mock, beforeEach } from "bun:test";

const createLocalStorageMock = () => {
  const store = new Map();
  return {
    getItem: (key) => (store.has(key) ? store.get(key) : null),
    setItem: (key, value) => store.set(key, String(value)),
    removeItem: (key) => store.delete(key),
    clear: () => store.clear(),
    key: (index) => Array.from(store.keys())[index] ?? null,
    get length() {
      return store.size;
    },
  };
};

describe("ApiService", () => {
  beforeEach(() => {
    globalThis.localStorage = createLocalStorageMock();
    globalThis.fetch = mock();
  });

  test("request sends auth header when token is set", async () => {
    const { ApiService } = await import("./api.js");
    const service = new ApiService();
    service.setToken("token-123");

    fetch.mockResolvedValueOnce({
      ok: true,
      status: 200,
      json: async () => ({ success: true }),
    });

    const data = await service.get("/topics");
    const [url, config] = fetch.mock.calls[0];

    expect(url).toBe("/api/topics");
    expect(config.headers.Authorization).toBe("Bearer token-123");
    expect(data.success).toBe(true);
  });

  test("request throws normalized network error for fetch failure", async () => {
    const { ApiService } = await import("./api.js");
    const service = new ApiService();

    fetch.mockRejectedValueOnce(new TypeError("fetch failed"));

    await expect(service.get("/health")).rejects.toThrow(
      "Network error: Unable to connect to server. Check if backend is running.",
    );
  });

  test("clearUserSpecificData only removes namespaced keys", async () => {
    const { ApiService } = await import("./api.js");
    const service = new ApiService();

    localStorage.setItem("focusModeSettings_user1", "a");
    localStorage.setItem("userSettings_user1", "b");
    localStorage.setItem("accessToken", "token");

    service.clearUserSpecificData();

    expect(localStorage.getItem("focusModeSettings_user1")).toBeNull();
    expect(localStorage.getItem("userSettings_user1")).toBeNull();
    expect(localStorage.getItem("accessToken")).toBe("token");
  });
});
