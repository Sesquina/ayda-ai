# Medalyn

Medalyn is a caregiver assistant prototype built with Flutter and Firebase. The project demonstrates the login → upload → summary journey with mocked data while keeping the structure ready for production integrations.

## 🌿 Medalyn — Health Communication Platform

Medalyn is a **health communication layer** that converts unstructured medical data into structured, plain-language insights for families. The platform offers a web UI for caregivers and APIs that clinics, payers, and partners can embed.

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
  - triageSymptoms()
  - getMedicationReminders()
  - matchClinicalTrials()
  - aggregateOrgMetrics()
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
* `triage_logs`: inputs, riskLevel, advice, response latency
* `er_scripts`: patient context, vitals text, medications, key phrases
* `meds`: name, schedule, dose, reminders[]
* `reminders`: medId or followUpId, channel, nextRun
* `reminder_logs`: ownerUid, orgId, remindersReturned, delivery channel
* `family_updates`: audience, channels, renderedText
* `trial_profiles`: diagnosis, stage, biomarkers, inclusion/exclusion
* `trial_matches`: profileId, trialId, matchScore
* `trial_logs`: profileId, matchesReturned, topScore, followUpStatus
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

## 🧠 Medalyn Intelligence API

The new callable wrappers (`MedalynApi`) form the commercial core of the platform. Each endpoint is a productized capability with
clear buyers and monetization paths.

| Tier                        | Audience / Use case                                      | Pricing signal (target) |
| -------------------------- | -------------------------------------------------------- | ----------------------- |
| **Free (Consumer)**        | Individual caregivers running summaries and reminders    | $0                      |
| **Pro (Clinician)**        | Multi-patient dashboard, red-flag alerts                 | $29–$49 per month       |
| **Enterprise (Hospital)**  | Bulk API access, analytics exports, SSO, admin controls  | $2K–$10K per org / mo   |
| **Research & SBIR**        | De-identified literacy datasets for grants and studies    | Custom agreements       |

Every API call writes structured telemetry (`summaries`, `triage_logs`, `reminder_logs`, `trial_logs`) that powers the metric
pipeline for SBIR evidence and VC diligence.

---

## 📊 Analytics dashboard & KPI pipeline

The admin dashboard surfaces the outcomes that SBIR reviewers, partners, and investors care about:

* caregiver comprehension lift and reading-level distribution
* thumbs-up feedback rate trends
* monthly red-flag totals
* trial-matching conversions per organization

### Metrics pipeline

1. `summaries/{id}` documents now include a `COMPREHENSION_SCORE`, `readingLevel`, and `redFlagsCount` fields.
2. The scheduled Cloud Function `aggregateOrgMetrics` (see `functions/src/aggregateMetrics.ts`) runs every 24 hours.
3. It fans out across `summaries`, groups them by `orgId` and month, and stores rollups under `orgs/{orgId}/metrics/{yyyy-MM}`.
4. The Flutter dashboard (`app/lib/features/admin/presentation/admin_screen.dart`) reads those rollups and renders cards plus a trend line.

### Demo data for local previews

Seed Firestore with the sample metrics in `functions/sample-data/demo_org_metrics.json`:

```bash
firebase firestore:documents:update orgs/demo_org/metrics/2024-10 \
  avgReadingLevel=6.5 avgComprehension=0.83 feedbackPositiveRate=0.86 \
  redFlagsTotal=9 caregiversCount=41 updatedAt=$(date +%s000)
```

Repeat for the additional months you want to showcase. The admin dashboard listens in real time and will refresh automatically.

---

## 💰 Business model & market sizing

| Stream | Description | 2027 forecast |
| ------ | ----------- | -------------- |
| **B2B SaaS licenses** | Clinics pay per seat for comprehension analytics and dashboards | $50M ARR |
| **API access** | Hospitals embed summarization & comprehension APIs into portals | $20M |
| **Enterprise analytics** | Payers purchase aggregated literacy insights (de-identified) | $15M |
| **Clinical trial referral fees** | Sponsors pay per qualified candidate | $10M |
| **Consumer premium tier** | Caregivers upgrade for advanced reminders & bilingual coaching | $5M |

Global health-literacy technology is a ~$20B TAM. Capturing even 0.5% positions Ayda beyond the $100M revenue mark required for a venture-scale valuation.

---

## 📈 Data & analytics strategy

| Data type | Use | Value |
| --------- | --- | ----- |
| `COMPREHENSION_SCORE` logs | Quantifies literacy improvements for SBIR evidence | Clinical + regulatory proofs |
| Reading-level trendlines | Highlights patient engagement and quality gaps | Provider & payer analytics |
| Red-flag incidence | Tunes proactive alerts and risk detection | Safety and liability moat |
| Bilingual translation feedback | Measures cultural resonance and accessibility | Global expansion story |
| Trial-matching performance | Increases recruitment throughput | Pharma and life-sciences revenue |

Longitudinal analytics unlock benchmarking ("Your caregivers improved comprehension by 28% this quarter"), population literacy indices for public-health partners, and predictive insights that link comprehension to readmission avoidance.

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
