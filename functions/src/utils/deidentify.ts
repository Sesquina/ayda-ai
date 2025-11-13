export function deidentify(input: string): string {
  // Very simple placeholder. Replace with proper PHI stripping.
  return input
    .replace(/\b[A-Z][a-z]+ [A-Z][a-z]+\b/g, "REDACTED_NAME")
    .replace(/\b\d{2}\/\d{2}\/\d{4}\b/g, "REDACTED_DATE")
    .replace(/\b\d{3}-\d{2}-\d{4}\b/g, "REDACTED_ID");
}
