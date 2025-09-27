import { ui, showDefaultLang, defaultLang } from "./ui";

export function getLangFromUrl(url: URL) {
  const [, lang] = url ? url.pathname.split("/") : [undefined, defaultLang];
  if (lang in ui) return lang as keyof typeof ui;
  return defaultLang;
}

export function getLangFromPath(path: String) {
  const [, lang] = path.split("/");
  if (lang in ui) return lang as keyof typeof ui;
  return defaultLang;
}

export function useTranslations(lang: keyof typeof ui) {
  return function t(
    key: keyof (typeof ui)[keyof typeof ui],
    values: Record<string, string> = {}
  ): string {
    const value: string = ui[lang]?.[key] || ui[defaultLang]?.[key] || "";
      return value.replace(/\{\{(\w+)\}\}/g, (match: string, capturedKey: string) => {
      return capturedKey in values ? values[capturedKey] : match;
    });
  };
}

export function useTranslatedPath(lang: keyof typeof ui) {
  return function translatePath(path: string, l: string = lang) {
    return !showDefaultLang && l === defaultLang ? path : `/${l}${path}`
  }
}