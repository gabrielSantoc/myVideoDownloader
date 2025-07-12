import { sanitizeTitle } from "./sanitizeTitle";

export  function getSanitizedTitle(stdout: string): string {
  try {
    const data = JSON.parse(stdout);
    const fileTitle = sanitizeTitle(data.title);
    console.log('🟢 >>> CLEAN TITLE:', fileTitle);
    return fileTitle;
  } catch (err) {
    console.error(' Error parsing video info:', err);
    throw new Error('Cannot parse video info');
  }
}