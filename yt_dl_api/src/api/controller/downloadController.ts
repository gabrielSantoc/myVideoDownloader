import {Request, Response} from 'express';
import {exec} from 'child_process'
import path from 'path';
import { stderr } from 'process';

const ffmpegDir = path.resolve(__dirname, '../../../bin');

export function downloadVidController( req: Request, res: Response ) {

  const url: string = req.body.url;
  const quality: string = req.body.quality || '720';
  const audioOnly: boolean = req.body.audioOnly || false;

  if(!url) {
    res.status(500).json({ error: "URL is required" });
  }

  let command = 'yt-dlp';

  if (audioOnly) {
    command += ' -x --audio-format mp3';
    console.log('⬇ Downloading audio only ...');
  } else {
    command += ` -f "best[height<=${quality}]"`;
    console.log('⬇ Downloading video quality: ', quality);
  }

  // set output filename format
  // command += ` -o "downloads/%(title)s.%(ext)s" "${url}"`;
  command += ` -o "downloads/%(title)s.%(ext)s" --ffmpeg-location="${ffmpegDir}" --no-check-certificates --user-agent "Mozilla/5.0"`;
  
  console.log('➡ Executing command:', command);

  command += ` "${url}"`;

  // execute download command
  exec(command, { timeout: 300000 }, (error, stdout, stderr) => {

    if(error) {
      console.log("Download error: ", error.message);
      console.log("stderr: ", stderr)
      return res.status(500).json({
        error: "Download failed",
        details: error.message
      });
    }

    console.log("Download completed successfully");
    console.log("stdout:", stdout);
    return res.json({
      success: true,
      message: 'Download Completed'
    });

  })

}
