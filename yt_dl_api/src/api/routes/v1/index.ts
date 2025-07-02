import { Router } from 'express';
import { infoController } from '../../controller/infoController';

const router: Router = Router();

router.post('/video/info', infoController);

export default router;

