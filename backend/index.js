require('dotenv').config();
const express = require('express');
const connectDB = require('./config/db');
const cors = require('cors');

const menuRoutes = require('./routes/cafeteriamenu.route');
const scheduleRoutes = require('./routes/classschedule.route');
const todoRoutes = require('./routes/todo.route');
const facultyRoutes = require('./routes/facultyinfo.route');
const eventClubRoutes = require('./routes/evenClubroute');
const { studentRoutes, teacherRoutes, cafeteriaManagerRoutes, clubManagerRoutes } = require('./routes/user.routes');

const app = express();
app.use(express.json());
app.use(cors());

// Connect to MongoDB
connectDB();

// Routes
app.use('/menu', menuRoutes);
app.use('/schedule', scheduleRoutes);
app.use('/todos', todoRoutes);
app.use('/facultycontact',facultyRoutes);
app.use('/api', studentRoutes);
app.use('/api', teacherRoutes);
app.use('/api', cafeteriaManagerRoutes);
app.use('/api', clubManagerRoutes);
app.use('/api', eventClubRoutes);


const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));
