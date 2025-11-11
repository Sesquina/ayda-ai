export function bilingualFormat(text: string, lang: "en" | "es" = "en"): string {
  // Placeholder. Later: call translation API or prompt LLM for target language.
  if (lang === "es") return `ES: ${text}`;
  return text;
}
