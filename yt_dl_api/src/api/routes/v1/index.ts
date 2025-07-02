import { Router } from 'express';
import { vidInfoController } from '../../controller/infoController';
import { downloadVidController } from '../../controller/downloadController';

const router: Router = Router();

router.post('/video/info', vidInfoController);

router.post('/video/download', downloadVidController);

export default router;

