import { Request, Response } from 'express'
import { exec } from 'child_process'

export function vidInfoController ( req: Request, res: Response ) {
  const { url } = req.body;
  
  if(!url) {
    res.json({ error: 'URL is required' })
  } 

  // get vid info 
  const command = `yt-dlp -J "${url}"`;
  console.log(`>>> Video URL info for "${url}"`);

  exec(command, (error, stdout) => {
    if(error) {
      console.log('Error getting video info: ', error.message);
      return res.status(500).send({ error: 'Cannot get video info' });
    }

    try{
      const data = JSON.parse(stdout);

      const info = {
        title: data.title,
        duration: data.duration,
        thumbnail: data.thumbnail,
        videoUrl: url
      }

      console.log('Video info retrieved: ', info.title);
      return res.status(200).json({info});

    }catch(err) {

      console.log('Error parsing video info: ', err);
      return res.status(500).json({ error: 'cannot parse video info'})

    }

  });

}