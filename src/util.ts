import chalk from "chalk";
import { Request } from "express";

export const logger = {
  count: (req: Request, arr: any[]) =>
  console.log(chalk`{rgb(255,255,255).bgBlue  ${req.route.path} } returning ${arr.length} results to ${req.headers.origin}`)
    
}