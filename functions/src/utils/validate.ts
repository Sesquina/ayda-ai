import { z } from "zod";

export const zSummarizeInput = z.object({
  recordId: z.string().min(1),
  lang: z.enum(["en", "es"]).optional(),
});

export const zTriageInput = z.object({
  ownerUid: z.string().min(1),
  symptoms: z.array(z.string()).min(1),
  duration: z.string().min(1),
  vitals: z.record(z.any()).optional(),
  lang: z.enum(["en", "es"]).optional(),
});

export const zERScriptInput = z
  .object({
    sessionId: z.string().optional(),
    recordId: z.string().optional(),
  })
  .refine((d) => d.sessionId || d.recordId, { message: "Provide sessionId or recordId" });

export const zReminderInput = z.object({
  reminderId: z.string().min(1),
});

export const zTrialMatchInput = z.object({
  profileId: z.string().min(1),
});
