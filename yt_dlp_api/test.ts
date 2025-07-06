
import { exec } from 'child_process'

const url = "https://youtu.be/pBa_QBlW4OA?si=yKrgc5QAyrdqYrfC"
// const url = "https://www.facebook.com/reel/1525212985126244"
const listAllFormatsCommand = `yt-dlp --list-formats "${url}"`;
const fullMetaDataJsonCommand = `yt-dlp -j "${url}"`;

console.log(`🔄 >>> Video URL "${url}"`);

exec( listAllFormatsCommand, (error, stdout) => {
  if(error) {
    console.log("Error:", error);
  }

  const formats: QualityFormat[] = [];
  const seen = new Set<string>();

  stdout.split('\n').forEach((line, index) => {
    console.log(`🟢 >>> LINE ${index + 1}: ${line}`);
    
    const parts = line.trim().split(/\s+/);
    
    console.log(`🟢 >>> PARTS ${index + 1}: ${parts}`);
    console.log(`🟢 >>> PARTS ${index + 1} LENGTH: ${parts.length}`);
    console.log(`🟢 >>> PARTS ${index + 1} FORMAT ID: ${ parts[0] }`);
    console.log(`🟢 >>> PARTS ${index + 1} EXT: ${ parts[1] }`);
    const filesize = extractFileSize(parts.slice(2).join(' '));
    console.log(`🟢 >>> PARTS ${index + 1} FILE SIZE: ${  filesize }`);
    console.log(`🟢 >>> PARTS ${index + 1} DESCRIPTION: ${  parts.slice(2).join(' ') }`);
    console.log("");

    if(parts.length < 3 || line.includes('ID') || line.includes('---')) {
      return;
    }

    const format_id = parts[0];
    const ext = parts[1];
    const description = parts.slice(2).join(' ');

    // check if video or audio
    const isAudio = description.includes('audio');
    const type = isAudio ? 'audio' : 'video';
    
    // Extract resolution
    let resolution = 'unknown';

    if(isAudio) {
      resolution = 'audio only';
    } else {
      const extractedRes = extractResolution(description);
      if(extractedRes) {
        resolution = extractedRes;
      }
    }

    // const filesize = extractFileSize(description);

    const key = `${resolution}-${type}-${ext}`;
    if(resolution !== 'unknown' && !seen.has(key)) {
      formats.push({
        format_id,
        resolution,
        ext,
        type,
        filesize
      });
      seen.add(key)
    }

  }) 
  console.log("FORMATS : ", formats); 
});


function extractResolution(description: string): string | undefined {
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

function extractFileSize(description: string): string | undefined {
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

interface QualityFormat {
  format_id: string
  resolution: string
  ext: string
  type: 'video' | 'audio'
  filesize?: string
}
