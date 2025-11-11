import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

// Initialize once (safe to call multiple times in emulator/local setups)
try {
  admin.initializeApp();
} catch (e) {
  // ignore if already initialized
}

/**
 * Callable stub for summarizing medical documents.
 * Replace with real OpenAI integration in a production implementation.
 */
export const summarize = functions.https.onCall(async (data, context) => {
  // Basic auth guard
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Authentication required.');
  }

  const documentText = data?.text || data?.documentText || '';
  const language = data?.language || 'en';

  // Simple deterministic stubbed response
  const summary = documentText
    ? `${documentText.slice(0, 240)}${documentText.length > 240 ? '…' : ''}`
    : 'No document text provided.';

  return {
    summary: `Stub summary (${language}): ${summary}`,
    alerts: [],
    language,
    originalLength: documentText.length,
  };
});
