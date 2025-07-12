import { Request, Response } from 'express';
import { exec } from 'child_process';
import path from 'path';
import { getSanitizedTitle } from '../../utils/getSantizeTitle';

const ffmpegDir = path.resolve(__dirname, '../../../bin');
export function downloadVidController(req: Request, res: Response) {
  const url: string = req.body.url;
  const quality: string = req.body.quality || '720';
  const audioOnly: boolean = req.body.audioOnly || false;

  if (!url) {
    res.status(400).json({ error: "URL is required" });
  }

  // get vid info
  exec(`yt-dlp -J ${url}`, (err, stdout) => {
    if (err) {
      console.error('Error getting video info:', err.message);
      res.status(500).send({ error: 'Cannot get video info' });
    }

    let fileTitle = getSanitizedTitle(stdout);

    let command = 'yt-dlp';

    if (audioOnly) {
      command += ' -x --audio-format mp3';
      console.log('⬇ Downloading audio only...');
    } else {
      command += ` -f "best[height<=${quality}]"`;
      console.log('⬇ Downloading video quality:', quality);
    }

    command += ` -o "downloads/${fileTitle}.%(ext)s" --ffmpeg-location="${ffmpegDir}" --no-check-certificates --user-agent "Mozilla/5.0" "${url}"`;
    console.log('➡ Executing command:', command);
    // download video
    exec(command, { timeout: 300000 }, (err, stdout, stderr) => {
      if (err) {
        console.error('Download error:', err.message);
        console.error('stderr:', stderr);
        return res.status(500).json({
          error: 'Download failed',
          details: err.message,
        });
      }

      return res.json({
        success: true,
        message: 'Download completed',
        filename: `${fileTitle}`,
      });
    });
  });
}
