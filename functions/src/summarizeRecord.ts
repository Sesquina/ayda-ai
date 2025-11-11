import { onCall, HttpsError } from "firebase-functions/v2/https";

import { db } from "./utils/firebase";
import { deidentify } from "./utils/deidentify";
import { readingLevelScore } from "./utils/readingLevel";
import { bilingualFormat } from "./utils/bilingual";
import { zSummarizeRecordInput } from "./utils/validate";

type SummarySection = {
  title: string;
  body: string;
};

type SummarizeRecordResult = {
  summaryId: string;
  readingLevel: number;
  comprehensionScore: number;
  sections: SummarySection[];
};

function buildError(error: unknown): HttpsError {
  if (error instanceof HttpsError) {
    return error;
  }

  return new HttpsError("invalid-argument", "Invalid payload", error);
}

export const summarizeRecord = onCall({ cors: true, enforceAppCheck: false }, async (request) => {
  const parsed = zSummarizeRecordInput.safeParse(request.data);
  if (!parsed.success) {
    throw buildError(parsed.error.flatten());
  }

  const { uid, orgId, text, recordId, lang = "en" } = parsed.data;

  if (!uid) {
    throw new HttpsError("failed-precondition", "User identifier is required");
  }

  const cleaned = deidentify(text);

  const summaryText = recordId
    ? `Summary placeholder for record ${recordId}.` // TODO: Replace with LLM integration.
    : "Summary placeholder. Provide recordId to personalize messaging.";

  const readingLevel = readingLevelScore(summaryText);
  const comprehensionScore = Math.max(0, Math.min(1, 1 - Math.abs(readingLevel - 8) / 10));
  const sections: SummarySection[] = [
    { title: "Main Findings", body: bilingualFormat(summaryText, lang) },
  ];

  const docRef = await db.collection("summaries").add({
    ownerUid: uid,
    orgId: orgId ?? null,
    recordId: recordId ?? null,
    lang,
    cleanedLength: cleaned.length,
    sections,
    readingLevel,
    COMPREHENSION_SCORE: comprehensionScore,
    redFlags: [],
    redFlagsCount: 0,
    createdAt: Date.now(),
  });

  const payload: SummarizeRecordResult = {
    summaryId: docRef.id,
    readingLevel,
    comprehensionScore,
    sections,
  };

  return payload;
});
