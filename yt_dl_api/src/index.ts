import { startServer } from "./server";
import { checkDownloadDir } from './utils/checkDownloadDir';
import path from "path";


startServer();

checkDownloadDir()
