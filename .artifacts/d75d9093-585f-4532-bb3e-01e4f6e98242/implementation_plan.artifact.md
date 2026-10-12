# Fix Serverpod Auth Timeout and Port Conflicts

This plan addresses the `TimeoutException` occurring during the Flutter app's authentication initialization and resolves a port conflict in the Serverpod server configuration.

## User Review Required

> [!IMPORTANT]
> The server's Web port will be changed from `8080` to `8082` to avoid conflict with the API port. Ensure you update any bookmarks or external services pointing to the web server.

## Proposed Changes

### [Server Configuration]

#### [MODIFY] [development.yaml](file:///C:/Users/timot/Desktop/chatwit/chatwit_server/config/development.yaml)
- Change `webServer.port` and `webServer.publicPort` to `8082`.
- (Already partially applied, but ensuring consistency).

---

### [Flutter Client]

#### [MODIFY] [main.dart](file:///C:/Users/timot/Desktop/chatwit/chatwit_flutter/lib/main.dart)
- Explicitly use `10.0.2.2` for the default server URL on Android to ensure reliable connection from the emulator.
- Wrap `client.auth.initialize()` in a try-catch block with a retry mechanism or at least log the error gracefully to prevent the app from crashing immediately on a transient timeout.

---

### [Server Logic]

#### [MODIFY] [server.dart](file:///C:/Users/timot/Desktop/chatwit/chatwit_server/lib/server.dart)
- Verify that `UserProfile` is correctly handled. If it's a custom model that is missing its definition, it might cause the server to crash on startup. I will double-check the model availability.

## Verification Plan

### Automated Tests
- Restart the Serverpod server and verify it starts without port binding errors.
- Run the Flutter app on the emulator and monitor the logs for successful auth initialization.

### Manual Verification
- Verify the server is accessible at `http://localhost:8080/` (API) and `http://localhost:8082/` (Web).
- Check that the Flutter app moves past the loading screen and reaches the Login or Feed screen.
