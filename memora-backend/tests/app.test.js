const { describe, test, expect } = require("bun:test");
const { beforeAll, afterAll } = require("bun:test");
const { createServer } = require("http");

process.env.JWT_SECRET = process.env.JWT_SECRET || "test-jwt-secret";
process.env.JWT_REFRESH_SECRET = process.env.JWT_REFRESH_SECRET ||
  "test-jwt-refresh-secret";
process.env.NODE_ENV = process.env.NODE_ENV || "test";

const { app } = require("../app");

let server;
let baseUrl;

beforeAll(async () => {
  server = createServer(app);
  await new Promise((resolve) => {
    server.listen(0, resolve);
  });
  const address = server.address();
  baseUrl = `http://127.0.0.1:${address.port}`;
});

afterAll(async () => {
  await new Promise((resolve, reject) => {
    server.close((error) => {
      if (error) {
        reject(error);
        return;
      }
      resolve();
    });
  });
});

describe("backend app routes", () => {
  test("GET /api/health returns OK payload", async () => {
    const response = await fetch(`${baseUrl}/api/health`);
    const body = await response.json();

    expect(response.status).toBe(200);
    expect(body.status).toBe("OK");
    expect(body.message).toContain("running");
    expect(typeof body.timestamp).toBe("string");
  });

  test("GET / responds with endpoints map", async () => {
    const response = await fetch(`${baseUrl}/`);
    const body = await response.json();

    expect(response.status).toBe(200);
    expect(body.status).toBe("running");
    expect(body.endpoints).toBeObject();
    expect(body.endpoints.health).toBe("/api/health");
  });

  test("unknown route returns 404", async () => {
    const response = await fetch(`${baseUrl}/this-route-does-not-exist`);
    const body = await response.json();

    expect(response.status).toBe(404);
    expect(body.message).toBe("Route not found");
  });
});
