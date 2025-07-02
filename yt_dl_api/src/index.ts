import { startServer } from "./server";
import path from "path";
import fs from 'fs';

startServer();

if(!fs.existsSync('downloads')) {
  fs.mkdirSync('downloads');
  console.log("✅ downloads folder created");
}