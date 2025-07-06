export function extractResolution(description: string): string | undefined {
  const words = description.split(' ');
  // check for dimensions like 1920x1080
  for(const word of words) {
  
    if(word.includes('x')) {
      const parts = word.split('x');
      if(parts.length === 2 && !isNaN(Number(parts[1]))) {
        return parts[1] + 'p'; // height for resolution
      }
    }
  }
  return undefined;
}