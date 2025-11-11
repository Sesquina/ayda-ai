import { onSchedule } from "firebase-functions/v2/scheduler";
import { getFirestore } from "firebase-admin/firestore";
import { getApps, initializeApp } from "firebase-admin/app";

if (!getApps().length) {
  initializeApp();
}

const db = getFirestore();

type SummaryDoc = {
  orgId?: string | null;
  ownerUid?: string;
  readingLevel?: number;
  COMPREHENSION_SCORE?: number;
  feedback?: string;
  redFlags?: unknown[];
  redFlagsCount?: number;
  createdAt?: number;
};

type MetricAccumulator = {
  readingLevels: number[];
  comprehensionScores: number[];
  positiveFeedback: number;
  totalFeedback: number;
  redFlags: number;
  caregivers: Set<string>;
};

function getMonthKey(timestamp?: number): string {
  const date = timestamp ? new Date(timestamp) : new Date();
  const year = date.getUTCFullYear();
  const month = `${date.getUTCMonth() + 1}`.padStart(2, "0");
  return `${year}-${month}`;
}

export const aggregateOrgMetrics = onSchedule("every 24 hours", async () => {
  const summariesSnap = await db.collection("summaries").get();

  const metricsByOrg = new Map<string, Map<string, MetricAccumulator>>();

  summariesSnap.forEach((doc) => {
    const data = doc.data() as SummaryDoc;
    if (!data.orgId) {
      return;
    }

    const monthKey = getMonthKey(data.createdAt);
    if (!metricsByOrg.has(data.orgId)) {
      metricsByOrg.set(data.orgId, new Map());
    }

    const orgMetrics = metricsByOrg.get(data.orgId)!;
    if (!orgMetrics.has(monthKey)) {
      orgMetrics.set(monthKey, {
        readingLevels: [],
        comprehensionScores: [],
        positiveFeedback: 0,
        totalFeedback: 0,
        redFlags: 0,
        caregivers: new Set<string>(),
      });
    }

    const bucket = orgMetrics.get(monthKey)!;

    if (typeof data.readingLevel === "number") {
      bucket.readingLevels.push(data.readingLevel);
    }

    if (typeof data.COMPREHENSION_SCORE === "number") {
      bucket.comprehensionScores.push(data.COMPREHENSION_SCORE);
    }

    if (data.feedback) {
      bucket.totalFeedback += 1;
      if (["up", "positive", "thumbs_up"].includes(data.feedback)) {
        bucket.positiveFeedback += 1;
      }
    }

    const redFlagsCount = Array.isArray(data.redFlags)
      ? data.redFlags.length
      : typeof data.redFlagsCount === "number"
        ? data.redFlagsCount
        : 0;
    bucket.redFlags += redFlagsCount;

    if (data.ownerUid) {
      bucket.caregivers.add(data.ownerUid);
    }
  });

  await Promise.all(
    Array.from(metricsByOrg.entries()).flatMap(([orgId, buckets]) =>
      Array.from(buckets.entries()).map(async ([monthKey, bucket]) => {
        const avg = (values: number[]) =>
          values.length ? values.reduce((sum, value) => sum + value, 0) / values.length : 0;

        const avgReading = avg(bucket.readingLevels);
        const avgComprehension = avg(bucket.comprehensionScores);
        const feedbackPositiveRate = bucket.totalFeedback
          ? bucket.positiveFeedback / bucket.totalFeedback
          : 0;

        await db
          .collection("orgs")
          .doc(orgId)
          .collection("metrics")
          .doc(monthKey)
          .set(
            {
              avgReadingLevel: avgReading,
              avgComprehension,
              feedbackPositiveRate,
              redFlagsTotal: bucket.redFlags,
              caregiversCount: bucket.caregivers.size,
              updatedAt: Date.now(),
            },
            { merge: true },
          );
      }),
    ),
  );
});
