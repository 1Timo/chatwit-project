# chatwit_flutter

## Run locally

Start the Serverpod API and database using the instructions in
[`chatwit_server/README.md`](../chatwit_server/README.md), then run the Flutter
app from this directory. Set `SERVER_URL` to the API server's reachable URL:

```sh
flutter run --dart-define=SERVER_URL=http://10.0.2.2:8080/
```

Common development URLs:

| Target | `SERVER_URL` |
| --- | --- |
| Android emulator | `http://10.0.2.2:8080/` |
| iOS simulator, desktop, or web on the same computer | `http://localhost:8080/` |
| Physical device | `http://<computer-lan-ip>:8080/` |

For a physical device, use the computer's LAN IP, ensure both devices are on the
same network, and allow inbound connections to port 8080. If the server returns
absolute public URLs for media, configure the Serverpod development
`apiServer.publicHost` in `chatwit_server/config/development.yaml` to an address
reachable from that device too. Relative media paths use `SERVER_URL`.

Sharing a post to followers sends a post preview through Chatwit messages and
does not require a public post URL. Both users must be able to reach the
configured `SERVER_URL` to use chats and load shared media.

The separate **Copy Link** action needs a URL that recipients can open. For
native builds, set `APP_URL` to the deployed Flutter app URL (including any
path prefix, if applicable), and host a route that can handle `/post/<id>`:

```sh
flutter run --dart-define=SERVER_URL=http://10.0.2.2:8080/ \
  --dart-define=APP_URL=https://your-public-app.example/
```

Web builds use the current browser URL when `APP_URL` is not set.
Without a public web URL, an app-only deep link scheme is another option, but it
requires platform link configuration and an in-app route that opens the post;
it only works for recipients who have the app installed. A copied URL cannot
open a post on another device until one of those destinations exists.

For example, if the computer's LAN IP is `192.168.0.101`, run the app with:

```sh
flutter run --dart-define=SERVER_URL=http://192.168.0.101:8080/
```

In VS Code, select the `chatwit_flutter (physical device)` launch
configuration for the phone. Keep using `chatwit_flutter` for the Android
emulator, which uses the default `10.0.2.2` address.

Replace the IP if it changes. The default `10.0.2.2` address is for Android
emulators and is not reachable from a physical phone.

Run Flutter's static checks and tests from this directory:

```sh
flutter analyze
flutter test
```
