import { CallableContext } from "firebase-functions/v2/https";
import { logger } from "firebase-functions";

interface SummaryHighlight {
  label: string;
  sentiment: "positive" | "neutral" | "negative";
}

interface SummaryNextStep {
  task: string;
  owner: string;
}

export interface SummarizeRecordPayload {
  documentId: string;
  storagePath: string;
  caregiverName?: string;
}

export interface SummarizeRecordResponse {
  summary: string;
  highlights: SummaryHighlight[];
  nextSteps: SummaryNextStep[];
}

export async function summarizeRecordHandler(
  data: SummarizeRecordPayload,
  context: CallableContext,
): Promise<SummarizeRecordResponse> {
  if (!context.auth) {
    throw new Error("Authentication required to call summarizeRecord.");
  }

  if (!data?.documentId || !data.storagePath) {
    throw new Error("documentId and storagePath are required fields.");
  }

  logger.info("Summarizing caregiver record", data);

  const caregiverName = data.caregiverName ?? "Care partner";

  return {
    summary: `${caregiverName} provided compassionate support. Energy remained stable and routines were respected throughout the shift.`,
    highlights: [
      {
        label: "Morning routine completed with enthusiasm",
        sentiment: "positive",
      },
      {
        label: "Mild confusion before lunch responded well to redirection",
        sentiment: "neutral",
      },
      {
        label: "Encourage hydration during afternoon activities",
        sentiment: "negative",
      },
    ],
    nextSteps: [
      {
        task: "Share summary with care coordinator",
        owner: caregiverName,
      },
      {
        task: "Schedule follow-up wellness check",
        owner: "Family team",
      },
    ],
  };
}
