import fs from 'fs';

export function checkDownloadDir() {
  if(!fs.existsSync('downloads')) {
    fs.mkdirSync('downloads');
    console.log("✅ downloads folder created");
  }
}