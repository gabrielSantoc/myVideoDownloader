import { Request, Response } from 'express'
import { exec } from 'child_process'
import { extractResolution } from '../../utils/extractRes'
import { extractFileSize } from '../../utils/extractFileSize'

interface QualityFormat {
  format_id: string
  resolution: string
  ext: string
  type: 'video' | 'audio'
  filesize?: string
}

export function qualitiesAndFormatsController(req: Request, res: Response) {
  const { url } = req.body;

  if (!url) {
    res.status(400).json({ error: 'URL is required' });
  }

  // command to get available formats
  const command = `yt-dlp --list-formats "${url}"`;
  console.log(`>>> Video URL "${url}"`);
  
  exec(command, (error, stdout) => {
    if (error) {
      console.log('Error getting video format: ', error.message);
      return res.status(500).json({ error: 'Cannot get video formats' });
    }

    const formats: QualityFormat[] = [];
    const seen = new Set<string>(); // Track unique format combinations
    
    stdout.split('\n').forEach(line => {

      // convert line into an array.
      const parts = line.trim().split(/\s+/);
      
      
      if (parts.length < 3 || line.includes('ID') || line.includes('---')) {
        return;
      }
      
      
      const format_id = parts[0]; // format_id 
      const ext = parts[1]; // extension
      const description = parts.slice(2).join(' '); // everything after extension
      
      // check if it is a video or audio
      const isAudio = description.includes('audio');
      const type = isAudio ? 'audio' : 'video';
      
      let resolution = 'unknown';

      if (isAudio) {
        resolution = 'audio only';
      } else {
        const extractedRes = extractResolution(description);
        if(extractedRes) {
          resolution = extractedRes;
        }
      }
      
      const filesize = extractFileSize(description)
      
      // Create unique identifier to avoid duplicates
      const key = `${resolution}-${type}-${ext}`;
      if (resolution !== 'unknown' && !seen.has(key)) {
        formats.push({
          format_id,
          resolution,
          ext,
          type,
          filesize
        });
        seen.add(key);
      }
    });

    // Check if any formats were found
    if (formats.length === 0) {
      return res.status(404).json({ error: 'No valid formats found' });
    }
    
    res.json({ availableFormats: formats.reverse() });
  });
}