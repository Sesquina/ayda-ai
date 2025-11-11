# Ayda AI

Ayda AI is a caregiver assistant prototype built with Flutter and Firebase. The project demonstrates the login → upload → summary journey with mocked data while keeping the structure ready for production integrations.

## 🌿 Ayda AI — Health Communication Platform

Ayda is a **health communication layer** that converts unstructured medical data into structured, plain-language insights for families. The platform offers a web UI for caregivers and APIs that clinics, payers, and partners can embed.

### Core value

* Make medical info understandable
* Reduce avoidable ER visits
* Improve adherence and coordination for families and care teams

### Who uses it

* Caregivers and patients (free)
* Providers, payers, and care programs through APIs and dashboards

---

## 🧩 Platform capabilities

**Document intelligence**

* OCR and parsing of PDFs and images
* Medical concept tagging (diagnoses, meds, labs)
* Plain-language summarization with bilingual output

**Care operations**

* Symptom check flows with clear “what to do next”
* ER handoff script generator

**Medication support**

* Med list, schedule, and reminders
* Calendar sync (ICS, Google, Apple)

**Family communication**

* Auto-generated SMS or WhatsApp updates
* Short, friendly tone; bilingual templates

**Clinical trial discovery**

* Profile-based eligibility pre-screen
* Links to apply and save candidates

**Offline fallback**

* Critical info cached on device
* Read-only workflows during outages

**Accessibility and safety**

* ADA and trauma-informed UI
* HIPAA-aligned handling, zero-PII prompts

---

## 🛣 Roadmap by phases

| Phase                     | Goal                     | Features                                                                  | Who benefits             |
| ------------------------- | ------------------------ | ------------------------------------------------------------------------- | ------------------------ |
| **V0.1 MVP**              | Validated summarization  | Upload, storage, Firestore metadata, AI summary, history, feedback, EN/ES | Caregivers               |
| **V0.2 Care Ops**         | Safety and decision help | Symptom triage, ER script, red-flag notices, audit log                    | Caregivers, ER           |
| **V0.3 Meds & Reminders** | Adherence                | Med list, reminders, calendar sync, refill prompts                        | Caregivers, primary care |
| **V0.4 Communication**    | Family alignment         | SMS and WhatsApp updates, bilingual templates, roles/permissions          | Families                 |
| **V0.5 Trials**           | Hope and options         | Profile capture, eligibility pre-screen, save/share trials                | Oncology, rare disease   |
| **V1.0 Platform**         | Scale and revenue        | Org admin dashboard, API keys, usage analytics, SSO, SLA                  | Providers, payers        |

Target order: V0.1 now, then V0.2 and V0.3. V0.4 and V0.5 follow once the base is stable. V1.0 when pilots begin.

---

## 🧱 System architecture

```
Flutter Web/Desktop (Material 3, Riverpod, go_router)
  ↕
Ayda SDK (client)     WhatsApp/SMS worker
  ↕                   (Twilio or WhatsApp Cloud API)
Firebase Auth • Firestore • Storage
  ↕
Cloud Functions (TypeScript)
  - summarizeRecord()
  - triageAssess()
  - generateERScript()
  - scheduleReminder()
  - matchTrials()
  - notifyFamily()
  - webhook handlers (Twilio/Meta)
  ↕
LLM Providers (de-identified text only)
UMLS-lite term mapping
Calendar (ICS/Google)
ClinicalTrials.gov ingestion cache
```

---

## 🔐 Data model (Firestore collections)

* `users`: profile, roles, locale
* `orgs`: multi-tenant boundary for enterprise pilots
* `records`: fileRef, ownerUid, orgId, status
* `summaries`: recordId, sections, redFlags[], readingLevel, lang
* `triage_sessions`: inputs, riskLevel, advice, erScriptId
* `er_scripts`: patient context, vitals text, medications, key phrases
* `meds`: name, schedule, dose, reminders[]
* `reminders`: medId or followUpId, channel, nextRun
* `family_updates`: audience, channels, renderedText
* `trial_profiles`: diagnosis, stage, biomarkers, inclusion/exclusion
* `trial_matches`: profileId, trialId, matchScore
* `feedback`: targetId, type, rating, comments
* `audit_logs`: actor, action, resource, timestamp

All documents scoped by `ownerUid` and optional `orgId`. Strict rules enforce ownership and least privilege.

---

## 🧪 Metrics that matter

* Comprehension gain: +30% over baseline in task tests
* Time to clarity: under 5 minutes from upload to useful summary
* Red-flag detection precision: ≥ 0.9 in labeled test set
* Adherence proxy: reminder interactions per week
* Retention: caregiver 30-day retention ≥ 35%
* NPS: ≥ 70 for caregivers

---

## 💼 Commercial alignment

* Caregiver access is free
* Platform revenue through provider and payer APIs
* APIs: summarize, triage, ER script, reminders, trial match
* Admin dashboard for usage analytics and audit trails

---

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

### Authentication
- Email/password sign-in is wired to FirebaseAuth. Create caregiver accounts with `Allow email/password` enabled in Firebase Authentication.
- The app listens to `authStateChanges()` and routes authenticated users directly to the upload workflow.

### Upload metadata
- Uploads are stored under the `uploads` collection in Firestore. Each entry tracks the owner ID, file name, generated storage path, status, notes, and tags.
- The upload screen currently simulates a file upload by creating Firestore metadata; integrate Firebase Storage to attach the actual binary.

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
The `summarizeRecord` callable function (`functions/src/index.ts`) returns mocked summary data today. Replace the implementation with your AI summarization pipeline once ready.

## Project structure
```
app/                  # Flutter application source
  lib/
    core/             # Shared theming and routing
    features/         # Auth, upload, summary, history, and future modules
  pubspec.yaml        # Flutter dependencies
brand/                # Brand assets
functions/            # Firebase Cloud Functions (TypeScript)
firestore.rules       # Firestore security rules
storage.rules         # Storage security rules
firebase.json         # Firebase configuration
```

## Next steps
- Configure Firebase Authentication providers beyond email/password (e.g., Google, SSO)
- Connect uploads to Firebase Storage and trigger summarizeRecord to enrich metadata
- Replace the mocked AI summary with a production-ready pipeline
- Expand automated tests and CI coverage
