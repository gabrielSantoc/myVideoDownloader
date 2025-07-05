import { Request, Response } from "express";
import { exec } from 'child_process';

export function fullMetaDataController(req: Request, res: Response) {
  const { url } = req.query;

  if (!url) {
    res.status(400).json({ error: 'URL is required' });
  }

  console.log("🟢 >> URL:", url);
  const command = `yt-dlp -J "${url}"`;

  exec(command, (error, stdout) => {
    if (error) {
      console.log('Error getting video meta-data: ', error.message);
      return res.status(500).json({ error: "Cannot get video meta-data" });
    }

    try {
      const data = JSON.parse(stdout);
      res.status(200).json({ data });
    } catch (err) {
      console.log('Error parsing video info: ', err);
      return res.status(500).json({ error: 'Cannot parse video info' });
    }
  });
}


