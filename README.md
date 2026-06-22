# RiderLink PH — User App

White-label ride-hailing and parcel delivery app for customers.

## Setup

```bash
# 1. Get dependencies
flutter pub get

# 2. Configure API credentials — edit these two files:
#    lib/main.dart      → FirebaseOptions (projectId, apiKey, appId, messagingSenderId)
#    lib/util/app_constants.dart → baseUrl, polylineMapKey

# 3. Set your backend URL in lib/util/app_constants.dart:
static const String baseUrl = 'https://your-backend-domain.com';

# 4. Set Google Maps API key (Web API) in lib/util/app_constants.dart:
static const String polylineMapKey = 'YOUR_GOOGLE_MAPS_WEB_API_KEY';

# 5. Build
flutter build web
flutter build apk --release
```

## Firebase Setup

Create a Firebase project, add an Android and iOS app, then paste the
`google-services.json` (Android) and `GoogleService-Info.plist` (iOS) into
the respective platform folders. Update `lib/main.dart` with the
`FirebaseOptions` from the Firebase console.

## Architecture

- **State management**: GetX
- **Localization**: Arabic + English built-in
- **Auth**: Laravel Passport (OAuth2) via REST API
- **Real-time**: Laravel Reverb (WebSockets)
- **Maps**: Google Maps JavaScript API + Directions API

## File Overview

| File | Purpose |
|------|---------|
| `lib/main.dart` | Firebase init, app bootstrap |
| `lib/util/app_constants.dart` | API endpoints, keys, shared constants |
| `lib/features/` | Screens and controllers by feature |
| `lib/helper/` | DI, API client, notification helpers |
| `web/index.html` | Web shell — update `<title>` to your brand |