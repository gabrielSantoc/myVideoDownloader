
import { exec } from 'child_process'

const url = "https://youtu.be/pBa_QBlW4OA?si=yKrgc5QAyrdqYrfC"
const listAllFormatsCommand = `yt-dlp --list-formats "${url}"`;
const fullMetaDataJsonCommand = `yt-dlp -j "${url}"`;

console.log(`>>> Video URL "${url}"`);

exec( listAllFormatsCommand, (error, stdout) => {
  if(error) {
    console.log("Error:", error);
  }

  const data = JSON.parse(stdout);
  console.log("🟢 >>> ", data);



} )