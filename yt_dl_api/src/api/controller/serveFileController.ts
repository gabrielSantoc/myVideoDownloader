import {Request, Response}  from 'express';
import path from 'path';
import fs from 'fs';

export function serveDownloadedFileController( req: Request, res: Response ) {

  const { fileName } = req.params;
  const downloadsDir = path.resolve( __dirname, '../../../downloads' )
  const vidFilePath = path.join( downloadsDir, fileName );

  if(!fs.existsSync(vidFilePath)) {
    res.status(404).json({ error: "File not found" });
  }

  res.setHeader('Content-Disposition', `attachment; filename="${fileName}"`);
  res.setHeader('Content-Type', 'application/octet-stream');

  const fileStream = fs.createReadStream(vidFilePath);
  fileStream.pipe(res);

  fileStream.on('end', () => {
    setTimeout( ()=> {
      if(fs.existsSync(vidFilePath)) {
        fs.unlinkSync(vidFilePath);
        console.log(`Cleaned up file: ${fileName}`);
      }
    }, 60000)
  })

}