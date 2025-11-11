# Ayda AI

Ayda AI is a caregiver assistant prototype built with Flutter and Firebase. The project demonstrates the login → upload → summary journey with mocked data while keeping the structure ready for production integrations.

## Getting started

### Prerequisites
- [Flutter 3.22+](https://docs.flutter.dev/get-started/install)
- [Firebase CLI](https://firebase.google.com/docs/cli) and `firebase-tools` installed
- Node.js 18 for running Cloud Functions locally

### Bootstrap the Flutter app
```bash
cd app
flutter pub get
flutter run
```

The Flutter project initializes Firebase using the configuration in `lib/firebase_options.dart`. Replace the placeholder bundle identifiers with your platform-specific IDs after running `flutterfire configure` for production use.

### Configure Firebase services
1. Authenticate with Firebase:
   ```bash
   firebase login
   ```
2. Select the `aydaai-1a95f` project:
   ```bash
   firebase use aydaai-1a95f
   ```
3. Deploy security rules:
   ```bash
   firebase deploy --only firestore:rules,storage:rules
   ```
4. Build and deploy Cloud Functions:
   ```bash
   cd functions
   npm install
   npm run build
   firebase deploy --only functions
   ```

### Cloud Functions
The `summarizeRecord` callable function (`functions/src/summarize.ts`) returns mocked summary data today. Replace the implementation with your AI summarization pipeline once ready.

## Project structure
```
app/                  # Flutter application source
  lib/
    core/             # Shared theming
    features/         # Auth, upload, summary, history flows
  pubspec.yaml        # Flutter dependencies
brand/                # Brand assets
functions/            # Firebase Cloud Functions (TypeScript)
firestore.rules       # Firestore security rules
storage.rules         # Storage security rules
firebase.json         # Firebase configuration
```

## Next steps
- Implement real Firebase Authentication flows
- Wire uploads to Firebase Storage and persist metadata in Firestore
- Connect the summarize Cloud Function to AI-powered text summarization
- Expand automated tests and CI coverage
