import express, {Request, Response} from 'express';
import routerV1 from "./api/routes/v1";

const app = express();

const PORT = process.env.PORT || 3000;

const startServer = () => {

  app.use(express.json());
  app.use('/api/', routerV1);


  app.listen(PORT, () => {
    console.log(`Server is running at PORT ${PORT}`)
  })
}

export { startServer };