import { startServer } from "./server";
import { checkDownloadDir } from './utils/checkDownloadDir';
import path from "path";
import fs from 'fs';

startServer();

checkDownloadDir()
