import express from 'express';
import petRoutes from './routes/petRoutes.js';
import dotenv from 'dotenv';
import connectDb from './database/db.js';
import cors from 'cors';

dotenv.config();
const app = express();

connectDb();

app.use(cors());

app.use(cors({ origin: /^http:\/\/localhost:\d+$/ }));

app.use(express.json());

app.use(petRoutes);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
