import { Router } from 'express';
import { vidInfoController } from '../../controller/infoController';
import { downloadVidController } from '../../controller/downloadController';
import { serveDownloadedFileController } from '../../controller/serveFileController';



const router: Router = Router();

router.post('/v1/video/info', vidInfoController);

router.post('/v1/video/download', downloadVidController);

router.get('/v1/video/download/:fileName',  serveDownloadedFileController);


export default router;

