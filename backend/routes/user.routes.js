const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { 
  Student, 
  Teacher, 
  CafeteriaManager, 
  ClubManager 
} = require('../model/user.model');

// Middleware for authentication
const authenticateUser = (req, res, next) => {
  const token = req.header('Authorization')?.replace('Bearer ', '');
  
  if (!token) {
    return res.status(401).json({ message: 'No token, authorization denied' });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded;
    next();
  } catch (error) {
    res.status(401).json({ message: 'Token is not valid' });
  }
};

// Generic CRUD Routes Generator
const createCRUDRoutes = (Model, modelName) => {
  // Create User
  router.post(`/${modelName}`, async (req, res) => {
    try {
      const { password, ...userData } = req.body;
      
      // Check if user already exists
      const existingUser = await Model.findOne({ email: userData.email });
      if (existingUser) {
        return res.status(400).json({ message: `${modelName} already exists` });
      }

      // Hash password
      const salt = await bcrypt.genSalt(10);
      const hashedPassword = await bcrypt.hash(password, salt);

      // Create new user
      const newUser = new Model({
        ...userData,
        password: hashedPassword
      });

      await newUser.save();

      res.status(201).json({ 
        message: `${modelName} created successfully`, 
        data: { 
          id: newUser._id, 
          name: newUser.name, 
          email: newUser.email 
        } 
      });
    } catch (error) {
      res.status(500).json({ 
        message: `Error creating ${modelName}`, 
        error: error.message 
      });
    }
  });

  // Login
  router.post(`/${modelName}/login`, async (req, res) => {
    try {
      const { email, password } = req.body;
      
      const user = await Model.findOne({ email });
      if (!user) {
        return res.status(400).json({ message: 'Invalid credentials' });
      }

      const isMatch = await bcrypt.compare(password, user.password);
      if (!isMatch) {
        return res.status(400).json({ message: 'Invalid credentials' });
      }

      // Generate JWT
      const token = jwt.sign(
        { 
          id: user._id, 
          email: user.email,
          type: modelName 
        }, 
        process.env.JWT_SECRET, 
        { expiresIn: '1h' }
      );

      res.json({ 
        token, 
        user: { 
          id: user._id, 
          name: user.name, 
          email: user.email 
        } 
      });
    } catch (error) {
      res.status(500).json({ 
        message: `${modelName} login error`, 
        error: error.message 
      });
    }
  });

  // Get All Users
  router.get(`/${modelName}`, authenticateUser, async (req, res) => {
    try {
      const users = await Model.find().select('-password');
      res.json(users);
    } catch (error) {
      res.status(500).json({ 
        message: `Error fetching ${modelName}s`, 
        error: error.message 
      });
    }
  });

  // Get User by ID
  router.get(`/${modelName}/:id`, authenticateUser, async (req, res) => {
    try {
      const user = await Model.findById(req.params.id).select('-password');
      if (!user) {
        return res.status(404).json({ message: `${modelName} not found` });
      }
      res.json(user);
    } catch (error) {
      res.status(500).json({ 
        message: `Error fetching ${modelName}`, 
        error: error.message 
      });
    }
  });

  // Update User
  router.put(`/${modelName}/:id`, authenticateUser, async (req, res) => {
    try {
      const { password, ...updateData } = req.body;
      
      // If password is being updated, hash it
      if (password) {
        const salt = await bcrypt.genSalt(10);
        updateData.password = await bcrypt.hash(password, salt);
      }

      const updatedUser = await Model.findByIdAndUpdate(
        req.params.id, 
        updateData, 
        { new: true, select: '-password' }
      );

      if (!updatedUser) {
        return res.status(404).json({ message: `${modelName} not found` });
      }

      res.json(updatedUser);
    } catch (error) {
      res.status(500).json({ 
        message: `Error updating ${modelName}`, 
        error: error.message 
      });
    }
  });

  // Delete User
  router.delete(`/${modelName}/:id`, authenticateUser, async (req, res) => {
    try {
      const deletedUser = await Model.findByIdAndDelete(req.params.id);
      
      if (!deletedUser) {
        return res.status(404).json({ message: `${modelName} not found` });
      }

      res.json({ 
        message: `${modelName} deleted successfully`, 
        data: deletedUser 
      });
    } catch (error) {
      res.status(500).json({ 
        message: `Error deleting ${modelName}`, 
        error: error.message 
      });
    }
  });

  return router;
};

// Export routes for each user type
module.exports = {
  studentRoutes: createCRUDRoutes(Student, 'student'),
  teacherRoutes: createCRUDRoutes(Teacher, 'teacher'),
  cafeteriaManagerRoutes: createCRUDRoutes(CafeteriaManager, 'cafeteriamanager'),
  clubManagerRoutes: createCRUDRoutes(ClubManager, 'clubmanager')
};
