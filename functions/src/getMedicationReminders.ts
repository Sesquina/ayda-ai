import { onCall, HttpsError } from "firebase-functions/v2/https";

import { db } from "./utils/firebase";
import { zGetMedicationRemindersInput } from "./utils/validate";

type Reminder = {
  id: string;
  medication: string;
  schedule: string;
  channel: "push" | "sms" | "email";
};

type ReminderPayload = {
  reminders: Reminder[];
};

export const getMedicationReminders = onCall({ cors: true }, async (request) => {
  const parsed = zGetMedicationRemindersInput.safeParse(request.data);
  if (!parsed.success) {
    throw new HttpsError("invalid-argument", "Invalid reminder payload", parsed.error.flatten());
  }

  const { uid, orgId } = parsed.data;

  const reminders: Reminder[] = [
    {
      id: "demo-reminder-1",
      medication: "Lisinopril 10mg",
      schedule: "08:00 daily",
      channel: "sms",
    },
    {
      id: "demo-reminder-2",
      medication: "Metformin 500mg",
      schedule: "20:00 daily",
      channel: "push",
    },
  ];

  await db.collection("reminder_logs").add({
    ownerUid: uid,
    orgId: orgId ?? null,
    remindersReturned: reminders.length,
    sampleReminderIds: reminders.map((item) => item.id),
    createdAt: Date.now(),
  });

  const payload: ReminderPayload = { reminders };
  return payload;
});
