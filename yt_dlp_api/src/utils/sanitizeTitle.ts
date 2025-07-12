export function sanitizeTitle(title: string): string {
  if (!title) return 'Unknown';
  
  let result = '';
  
  // Keep only letters and numbers, replace everything else with underscore
  for (const char of title) {
    if ((char >= 'a' && char <= 'z') || 
        (char >= 'A' && char <= 'Z') || 
        (char >= '0' && char <= '9')) {
      result += char;
    } else {
      result += '_';
    }
  }
  
  // Remove multiple underscores
  while (result.includes('__')) {
    result = result.split('__').join('_');
  }
  
  // Remove underscores from start and end
  if (result.startsWith('_')) result = result.substring(1);
  if (result.endsWith('_')) result = result.substring(0, result.length - 1);
  
  return result || 'Unknown';
}