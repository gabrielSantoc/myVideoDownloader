import { Router } from 'express';
import { vidInfoController } from '../../controller/infoController';
import { downloadVidController } from '../../controller/downloadController';
import { serveDownloadedFileController } from '../../controller/serveFileController';
import { qualitiesAndFormatsController } from '../../controller/qualitiesAndFormats';
import { fullMetaDataController } from '../../controller/fullMetaDataController';



const router: Router = Router();

router.post('/v1/video/info', vidInfoController);

router.get('/v1/video/info/meta-data', fullMetaDataController);

router.post('/v1/video/download', downloadVidController);

router.get('/v1/video/download/:fileName',  serveDownloadedFileController);

router.post('/v1/video/info/quality-formats', qualitiesAndFormatsController);


export default router;

