import { Request, Response } from 'express'
import { exec } from 'child_process'

interface QualityFormat {
  format_id: string
  resolution: string
  ext: string
  type: 'video' | 'audio'
  filesize?: string
}

export function qualityAndFormatsController(req: Request, res: Response) {
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
    
    // Process each line from yt-dlp output
    stdout.split('\n').forEach(line => {
      const parts = line.trim().split(/\s+/);
      
      // Skip header lines, separator lines, and empty lines
      if (parts.length < 3 || line.includes('ID') || line.includes('---')) {
        return;
      }
      
      // Parse format line (example: "140 m4a audio only tiny 129k dash")
      const format_id = parts[0];
      const ext = parts[1];
      const description = parts.slice(2).join(' '); // Everything after extension
      
      // Determine if this is audio or video format
      const isAudio = description.includes('audio');
      const type = isAudio ? 'audio' : 'video';
      
      // Extract resolution based on format type
      let resolution = 'unknown';
      if (isAudio) {
        resolution = 'audio only';
      } else {
        // Look for "1080p", "720p60", etc.
        const pMatch = description.match(/(\d+)p/);
        if (pMatch) {
          resolution = pMatch[1] + 'p';
        } else {
          // Look for "1920x1080", "1280x720", etc.
          const xMatch = description.match(/(\d+)x(\d+)/);
          if (xMatch) {
            resolution = xMatch[2] + 'p'; // Use height (second number)
          }
        }
      }
      
      // Extract file size if available (patterns like "129k", "50.5M")
      const filesize = description.match(/(\d+\.?\d*[kKmMgG])/)?.[1];
      
      // Create unique identifier to avoid duplicates
      const key = `${resolution}-${type}-${ext}`;
      if (resolution !== 'unknown' && !seen.has(key)) {
        formats.push({ format_id, resolution, ext, type, filesize });
        seen.add(key);
      }
    });

    // Check if any formats were found
    if (formats.length === 0) {
      return res.status(404).json({ error: 'No valid formats found' });
    }

    // Sort formats
    formats.sort((a, b) => {
      // Put video formats before audio formats
      if (a.type !== b.type) {
        if (a.type === 'video') {
          return -1; // a (video) comes before b (audio)
        } else {
          return 1;  // a (audio) comes after b (video)
        }
      }

      // If both are video, sort by resolution (highest to lowest)
      if (a.type === 'video') {
        const aRes = parseInt(a.resolution);
        const bRes = parseInt(b.resolution);
        return bRes - aRes;
      }

      // Leave audio formats in original order
      return 0;
    });
    
    res.json({ availableFormats: formats });
  });
}