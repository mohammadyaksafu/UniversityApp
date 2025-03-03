
require('dotenv').config();
const express = require('express');
const connectDB = require('./config/db');
const cors = require('cors');
const menuRoutes = require('./routes/cafeteriamenu.route');

const app = express();
app.use(express.json());
app.use(cors());

// Connect to MongoDB
connectDB();

// Routes
app.use('/menu', menuRoutes);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));
