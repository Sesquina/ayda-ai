export { summarizeRecord } from "./summarizeRecord";
export { triageSymptoms } from "./triageSymptoms";
export { getMedicationReminders } from "./getMedicationReminders";
export { matchClinicalTrials } from "./matchClinicalTrials";
export { aggregateOrgMetrics } from "./aggregateMetrics";
import * as admin from "firebase-admin";
import { onCall } from "firebase-functions/v2/https";
import { summarizeRecordHandler } from "./summarize";

admin.initializeApp();

export const summarizeRecord = onCall({
  region: "us-central1",
  enforceAppCheck: false,
}, summarizeRecordHandler);
