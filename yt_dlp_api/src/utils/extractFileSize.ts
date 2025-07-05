export function extractFileSize(description: string): string | undefined {
  const words = description.split(' ');

  for(const word of words) {
    const lastChar = word.slice(-1).toLocaleLowerCase();

    const isUnit = ['k', 'm', 'g'].includes(lastChar);
    const numberPart = word.slice(0, -1);

    if(isUnit && !isNaN(Number(numberPart))) {
      return word;
    }

  }
  return undefined;
}