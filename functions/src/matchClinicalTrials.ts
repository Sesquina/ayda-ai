import { onCall, HttpsError } from "firebase-functions/v2/https";

import { db } from "./utils/firebase";
import { zMatchClinicalTrialsInput } from "./utils/validate";

type TrialMatch = {
  trialId: string;
  title: string;
  score: number;
  url: string;
};

type MatchPayload = {
  matches: TrialMatch[];
};

export const matchClinicalTrials = onCall({ cors: true }, async (request) => {
  const parsed = zMatchClinicalTrialsInput.safeParse(request.data);
  if (!parsed.success) {
    throw new HttpsError("invalid-argument", "Invalid trial payload", parsed.error.flatten());
  }

  const { profileId, uid, orgId } = parsed.data;

  const matches: TrialMatch[] = [
    {
      trialId: "NCT00000000",
      title: "Example oncology study",
      score: 0.72,
      url: "https://clinicaltrials.gov/study/NCT00000000",
    },
  ];

  await db.collection("trial_logs").add({
    profileId,
    ownerUid: uid ?? null,
    orgId: orgId ?? null,
    matchesReturned: matches.length,
    topScore: matches[0]?.score ?? 0,
    createdAt: Date.now(),
  });

  const payload: MatchPayload = { matches };
  return payload;
});
