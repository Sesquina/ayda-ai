import { z } from "zod";

export const zSummarizeRecordInput = z.object({
  uid: z.string().min(1),
  text: z.string().min(1),
  orgId: z.string().min(1).optional(),
  recordId: z.string().min(1).optional(),
  lang: z.enum(["en", "es"]).optional(),
});

export const zTriageSymptomsInput = z.object({
  uid: z.string().min(1),
  orgId: z.string().min(1).optional(),
  symptoms: z.array(z.string().min(1)).min(1),
  duration: z.string().min(1),
  vitals: z.record(z.any()).optional(),
  lang: z.enum(["en", "es"]).optional(),
});

export const zGetMedicationRemindersInput = z.object({
  uid: z.string().min(1),
  orgId: z.string().min(1).optional(),
});

export const zMatchClinicalTrialsInput = z.object({
  profileId: z.string().min(1),
  uid: z.string().min(1).optional(),
  orgId: z.string().min(1).optional(),
});
