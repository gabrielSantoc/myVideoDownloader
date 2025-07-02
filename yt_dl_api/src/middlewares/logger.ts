import { Request, Response, NextFunction } from "express";
import moment, { months } from "moment"

const logger = (req: Request, res: Response, next: NextFunction) => {
  console.log(`[${moment().format('YYYY-MM-DD:mm:ss')}] ${req.method} ${req.protocol}://${req.get('host')}${req.originalUrl}`);
  next();
}

export default logger;
