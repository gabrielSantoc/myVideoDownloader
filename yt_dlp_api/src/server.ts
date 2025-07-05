import express, {Request, Response} from 'express';
import routerV1 from "./api/routes/v1";
import logger from "../src/middlewares/logger";
import cors from 'cors';

const app = express();

const PORT = process.env.PORT || 3000;

const startServer = () => {

  app.use(express.json());
  app.use(cors())
  app.use(logger);
  app.use('/api', routerV1);
  app.use('/downloads', express.static('downloads'));


  app.listen(PORT, () => {
    console.log(`Server is running at PORT ${PORT}`)
  })
}

export { startServer };