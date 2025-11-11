import { onCall, HttpsError } from "firebase-functions/v2/https";

import { db } from "./utils/firebase";
import { bilingualFormat } from "./utils/bilingual";
import { zTriageSymptomsInput } from "./utils/validate";

type TriagePayload = {
  sessionId: string;
  riskLevel: string;
  advice: string;
};

function calculateRiskLevel(symptoms: string[], duration: string): "low" | "medium" | "high" {
  const normalized = symptoms.map((item) => item.toLowerCase());

  if (normalized.some((item) => item.includes("chest pain") || item.includes("confusion"))) {
    return "high";
  }

  if (duration.toLowerCase().includes("week")) {
    return "medium";
  }

  return "low";
}

export const triageSymptoms = onCall({ cors: true }, async (request) => {
  const parsed = zTriageSymptomsInput.safeParse(request.data);
  if (!parsed.success) {
    throw new HttpsError("invalid-argument", "Invalid triage payload", parsed.error.flatten());
  }

  const { uid, orgId, symptoms, duration, vitals, lang = "en" } = parsed.data;

  const riskLevel = calculateRiskLevel(symptoms, duration);
  const advice = bilingualFormat(
    riskLevel === "high"
      ? "Seek emergency care immediately."
      : riskLevel === "medium"
        ? "Schedule a clinician visit within 24 hours."
        : "Monitor symptoms and contact your doctor if they worsen.",
    lang,
  );

  const doc = await db.collection("triage_logs").add({
    ownerUid: uid,
    orgId: orgId ?? null,
    symptoms,
    duration,
    vitals: vitals ?? null,
    riskLevel,
    advice,
    createdAt: Date.now(),
  });

  const payload: TriagePayload = {
    sessionId: doc.id,
    riskLevel,
    advice,
  };

  return payload;
});
