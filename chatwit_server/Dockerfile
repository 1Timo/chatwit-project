# Build from the project root with:
# docker build -f chatwit_server/Dockerfile .

# Use a specific, slim Dart SDK image to avoid vulnerabilities from the `latest` tag
FROM dart:3.8-slim AS build
WORKDIR /app

# Preserve locked dependencies and build the server binary.
COPY pubspec.lock ./
COPY chatwit_server ./chatwit_server
RUN printf '%s\n' \
  'name: _' \
  'environment:' \
  '  sdk: ^3.8.0' \
  'workspace:' \
  '  - chatwit_server' \
  > pubspec.yaml
RUN dart pub get
WORKDIR /app/chatwit_server
RUN dart compile exe bin/main.dart -o bin/server

# Use the current Debian stable slim image to pull in latest security fixes
# Use a specific Debian release to reduce unexpected vulnerable package updates
# Use a minimal, regularly-updated runtime image to reduce exposed vulnerabilities.
# gcr.io/distroless/cc-debian12 provides a small C/C++ runtime based on Debian 12 (bookworm)
# and is maintained with security updates. It removes package managers and shells which
# reduces attack surface compared to full Debian images.
FROM gcr.io/distroless/cc-debian12:nonroot AS runtime
WORKDIR /app

ENV runmode=production \
    serverid=default \
    logging=normal \
    role=monolith

COPY --chmod=0755 --from=build /app/chatwit_server/bin/server /app/server
COPY --from=build /app/chatwit_server/config/ /app/config/
COPY --from=build /app/chatwit_server/web/ /app/web/
COPY --from=build /app/chatwit_server/migrations/ /app/migrations/
COPY --from=build /app/chatwit_server/lib/src/generated/protocol.yaml /app/lib/src/generated/protocol.yaml

EXPOSE 8080 8081 8082
ENTRYPOINT ["/app/server"]
CMD ["--mode=production", "--server-id=default", "--logging=normal", "--role=monolith"]
