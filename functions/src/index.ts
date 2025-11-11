import * as admin from "firebase-admin";
import { onCall } from "firebase-functions/v2/https";
import { summarizeRecordHandler } from "./summarize";

admin.initializeApp();

export const summarizeRecord = onCall({
  region: "us-central1",
  enforceAppCheck: false,
}, summarizeRecordHandler);
