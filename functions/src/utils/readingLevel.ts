export function readingLevelScore(text: string): number {
  // Flesch-Kincaid-ish placeholder. Return approx grade level.
  const sentences = Math.max(1, (text.match(/[.!?]/g) || []).length);
  const words = Math.max(1, text.trim().split(/\s+/).length);
  const syllables = Math.max(1, text.toLowerCase().replace(/[^a-z]/g, "").length / 3);
  const flesch = 206.835 - 1.015 * (words / sentences) - 84.6 * (syllables / words);
  // Map to grade 1..12
  const grade = Math.min(12, Math.max(1, Math.round((100 - flesch) / 7)));
  return grade;
}
