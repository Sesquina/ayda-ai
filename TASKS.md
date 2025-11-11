# Ayda AI Build Plan

## 0. Baseline checks

- Ensure Flutter 3.24+, Firebase CLI auth, and `flutterfire configure` are complete
- Confirm GitHub Action deploy with `FIREBASE_DEPLOY_TOKEN`

## 1. Refactor for multi-tenant and roles

- Add `orgs` collection and `orgId` field to `users`, `records`, `summaries`, `audit_logs`
- Create `roles` array on `users` with values: caregiver, patient, admin, org_admin
- Update Firestore rules to enforce `request.auth.uid == resource.data.ownerUid` and org scoping for admins

## 2. Feature modules and routes

Create folders and screens:

```
app/lib/features/
  auth/           # done
  upload/         # done
  summary/
  triage/
  er_script/
  meds/
  reminders/
  family_updates/
  trials/
  settings/
  admin/          # org dashboard
```

Add routes in `core/router.dart`:

- `/`, `/login`, `/upload`, `/summary/:id`, `/history`
- `/triage`, `/er-script/:id`
- `/meds`, `/reminders`
- `/family-updates`
- `/trials`, `/trial-profile`, `/trial-matches`
- `/admin`

## 3. Cloud Functions to implement

Create or complete these TypeScript functions with input validation and de-id util:

- `summarizeRecord({ uid, text, recordId?, lang })`
  - De-identify text, call LLM, persist sections + `COMPREHENSION_SCORE` to `summaries/{id}`

- `triageSymptoms({ uid, symptoms, duration, vitals? })`
  - Rule-based risk level + optional LLM enrichment
  - Store telemetry in `triage_logs/{id}` with advice + timestamps

- `getMedicationReminders({ uid })`
  - Return normalized reminder payload and log access in `reminder_logs`

- `matchClinicalTrials({ profileId, uid? })`
  - Score cached trials, persist matches in `trial_logs`

- `notifyFamily(updateId)`
  - Channels: SMS, WhatsApp (Twilio or WhatsApp Cloud API). Store send status

Shared utils:

- `deidentify(text)`, `readingLevelScore(text)`, `bilingualFormat(text, lang)`

## 4. WhatsApp and SMS integration

- Add a `comms` submodule in functions: Twilio or Meta WhatsApp Cloud API client using environment secrets
- Webhook endpoint for delivery receipts
- Feature flag in Firestore to enable per user or org

## 5. Meds and reminders

- UI: list, add med, schedule picker
- Function: normalize dose and schedule, create `reminders`
- Calendar export: generate `.ics` per user and host on Firebase Hosting

## 6. Trials MVP

- `trial_profiles` form
- Simple matcher: disease label, stage, location, age
- Save candidates with match score and link out

## 7. Offline support

- Add local cache using `flutter_cache_manager` or `sqflite`
- Cache last N summaries, med list, ER script
- “Offline mode” banner and read-only flows

## 8. Accessibility and bilingual

- Add locale toggle EN/ES
- All strings via `intl` package
- Minimum 16 px body text, 4.5:1 contrast, focus states on all interactive elements

## 9. Analytics and audit

- Add `audit_logs` on key actions (upload, view, share, send)
- Minimal usage analytics per feature to `orgs/{orgId}/metrics`

## 10. Acceptance tests

- Golden tests for all screens
- Integration tests: upload → summary, triage → ER script, meds → reminder
- Rules tests for Firestore
