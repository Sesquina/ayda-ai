import { onCall, HttpsError } from "firebase-functions/v2/https";
import { getFirestore } from "firebase-admin/firestore";
import { getStorage } from "firebase-admin/storage";
import { initializeApp } from "firebase-admin/app";

import { deidentify } from "./utils/deidentify";
import { readingLevelScore } from "./utils/readingLevel";
import { bilingualFormat } from "./utils/bilingual";
import {
  zTriageInput,
  zSummarizeInput,
  zERScriptInput,
  zReminderInput,
  zTrialMatchInput,
} from "./utils/validate";

initializeApp();
const db = getFirestore();
const storage = getStorage();

/**
 * summarizeRecord(recordId)
 * Fetches the uploaded file, runs OCR if needed, de-identifies, maps concepts, calls LLM, stores summary.
 */
export const summarizeRecord = onCall({ cors: true, enforceAppCheck: false }, async (req) => {
  const parsed = zSummarizeInput.safeParse(req.data);
  if (!parsed.success) throw new HttpsError("invalid-argument", "Invalid payload");
  const { recordId, lang = "en" } = parsed.data;

  // 1) load record metadata
  const recRef = db.collection("records").doc(recordId);
  const recSnap = await recRef.get();
  if (!recSnap.exists) throw new HttpsError("not-found", "Record not found");
  const rec = recSnap.data() as any;

  // 2) load file from storage
  const file = storage.bucket().file(rec.filePath);
  const [buf] = await file.download();

  // 3) OCR or text extract (stub)
  const rawText = buf.toString("utf-8"); // TODO: detect PDF/image and run OCR

  // 4) de-id + concept mapping (stub)
  const clean = deidentify(rawText);
  // TODO: map to UMLS-lite concepts, extract red flags

  // 5) LLM call (stub for now)
  const summaryText = `Summary placeholder for record ${recordId}.`; // TODO: call OpenAI with clean text
  const rl = readingLevelScore(summaryText);

  // Simple comprehension heuristic: invert distance from target reading level (grade 8).
  const comprehensionScore = Math.max(0, Math.min(1, 1 - Math.abs(rl - 8) / 10));

  const finalText = bilingualFormat(summaryText, lang);

  // 6) persist
  const summaryRef = db.collection("summaries").doc();
  await summaryRef.set({
    id: summaryRef.id,
    recordId,
    ownerUid: rec.ownerUid,
    orgId: rec.orgId ?? null,
    lang,
    readingLevel: rl,
    sections: [{ title: "Main Findings", body: finalText }],
    redFlags: [],
    redFlagsCount: 0,
    COMPREHENSION_SCORE: comprehensionScore,
    createdAt: Date.now(),
  });
  return { summaryId: summaryRef.id };
});

/**
 * triageAssess(symptoms, duration, vitals?)
 * Lightweight rule-based plus LLM assist. Stores triage session.
 */
export const triageAssess = onCall({ cors: true }, async (req) => {
  const parsed = zTriageInput.safeParse(req.data);
  if (!parsed.success) throw new HttpsError("invalid-argument", "Invalid payload");
  const { ownerUid, symptoms, duration, vitals, lang = "en" } = parsed.data;

  // TODO: basic heuristic + optional LLM
  const riskLevel = "medium"; // low|medium|high
  const advice = bilingualFormat("Consider contacting your doctor within 24 hours.", lang);

  const doc = await db.collection("triage_sessions").add({
    ownerUid,
    symptoms,
    duration,
    vitals: vitals ?? null,
    riskLevel,
    advice,
    redFlags: [],
    createdAt: Date.now(),
  });
  return { sessionId: doc.id, riskLevel, advice };
});

/**
 * generateERScript(sessionId | recordId)
 * Produces a concise ER handoff script.
 */
export const generateERScript = onCall({ cors: true }, async (req) => {
  const parsed = zERScriptInput.safeParse(req.data);
  if (!parsed.success) throw new HttpsError("invalid-argument", "Invalid payload");
  const { sessionId, recordId } = parsed.data;

  // TODO: fetch triage session and summary, compose script
  const text = "ER script placeholder: chief complaint, meds, allergies, history.";
  const doc = await db.collection("er_scripts").add({
    text,
    sessionId: sessionId ?? null,
    recordId: recordId ?? null,
    createdAt: Date.now(),
  });
  return { erScriptId: doc.id, text };
});

/**
 * scheduleReminder(reminderId)
 * Creates ICS or schedules push/SMS via queue.
 */
export const scheduleReminder = onCall({ cors: true }, async (req) => {
  const parsed = zReminderInput.safeParse(req.data);
  if (!parsed.success) throw new HttpsError("invalid-argument", "Invalid payload");
  const { reminderId } = parsed.data;

  // TODO: build ICS and store public URL in Firestore, or enqueue SMS
  await db.collection("reminders").doc(reminderId).set({ scheduledAt: Date.now() }, { merge: true });
  return { ok: true };
});

/**
 * matchTrials(profileId)
 * Heuristic filter against cached trials.
 */
export const matchTrials = onCall({ cors: true }, async (req) => {
  const parsed = zTrialMatchInput.safeParse(req.data);
  if (!parsed.success) throw new HttpsError("invalid-argument", "Invalid payload");
  const { profileId } = parsed.data;

  // TODO: fetch profile, run inclusion/exclusion score
  const match = { trialId: "NCT00000000", score: 0.71, title: "Example Trial" };
  const doc = await db.collection("trial_matches").add({
    profileId,
    ...match,
    createdAt: Date.now(),
  });
  return { matchId: doc.id, match };
});

export { aggregateOrgMetrics } from "./aggregateMetrics";
