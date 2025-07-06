export function extractFileSize(description: string): string | undefined {
  const words = description.split(' ');

  for(const word of words) {
    if(word.includes('~')) {
      let sizePart = word;
      sizePart = sizePart.slice(1);

      let i = 0
      while(
        i < sizePart.length &&
        !isNaN(Number(sizePart[i])) ||
        sizePart[i] === '.'
      ) {
        i++
      }

      let numberPart = sizePart.slice(0, i);
      let unitPart = sizePart.slice(i);

      let sizeInMb: number;

      switch(unitPart) {
        case "KiB":
          sizeInMb = (Number(numberPart) * 1024) / 1_000_000;
          break;
        case "MiB":
          sizeInMb = (Number(numberPart) * 1_048_576) / 1_000_000;
          break;
        case "GiB":
          sizeInMb = (Number(numberPart) * 1_073_741_824) / 1_000_000;
          break;
        default:
          return undefined
      }
      
      return sizeInMb.toFixed(2) + 'MB';
    }
   
  }
  return undefined;
}