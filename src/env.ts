import dotenv from 'dotenv';
import z from 'zod';

dotenv.config();

const env = z
  .object({
    PORT: z.string(),
  })
  .parse(process.env);
export default env;
