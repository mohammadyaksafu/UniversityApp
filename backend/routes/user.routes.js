const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const Joi = require('joi'); 
const {  Student,  Teacher,  CafeteriaManager,  ClubManager } = require('../model/user.model');


// Base User Validation Schema
const baseUserValidationSchema = {
  name: Joi.string().required().min(2).max(50),
  email: Joi.string().email().required(),
  password: Joi.string().required().min(6),
  profileImage: Joi.string().optional().allow(''),
  contactNumber: Joi.string().optional(),
  isActive: Joi.boolean().optional(),
  createdAt: Joi.date().optional(),
};

// Student Validation Schema
const studentValidationSchema = Joi.object({
  ...baseUserValidationSchema,
  studentId: Joi.string().required(),
  department: Joi.string().required(),
  semester: Joi.number().required(),
  enrolledCourses: Joi.array().items(Joi.string().required()),
});

// Teacher Validation Schema
const teacherValidationSchema = Joi.object({
  ...baseUserValidationSchema,
  employeeId: Joi.string().required(),
  department: Joi.string().required(),
  designation: Joi.string().valid('Assistant Professor', 'Associate Professor', 'Professor', 'Lecturer').required(),
  courses: Joi.array().items(Joi.string().required()),
  officeLocation: Joi.string().optional(),
});

// Cafeteria Manager Validation Schema
const cafeteriaManagerValidationSchema = Joi.object({
  ...baseUserValidationSchema,
  managerId: Joi.string().required(),
  shiftTiming: Joi.object({
    start: Joi.string().required(),
    end: Joi.string().required(),
  }).required(),
  responsibleFor: Joi.string().valid('Main Cafeteria', 'Staff Cafeteria', 'Student Cafeteria').required(),
});

// Club Manager Validation Schema
const clubManagerValidationSchema = Joi.object({
  ...baseUserValidationSchema,
  managerId: Joi.string().required(),
  clubName: Joi.string().required(),
  clubType: Joi.string().valid('Technical', 'Cultural', 'Sports', 'Academic', 'Arts').required(),
  clubMembers: Joi.array().items(Joi.string().required()),
});


const loginValidationSchema = Joi.object({
  email: Joi.string().email().required(),
  password: Joi.string().required()
});


const validateRequest = (schema) => {
  return (req, res, next) => {
    const { error } = schema.validate(req.body);
    if (error) {
      return res.status(400).json({
        message: 'Validation error',
        details: error.details[0].message
      });
    }
    next();
  };
};


// Logging Middleware
const logRequest = (req, res, next) => {
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.path}`);
  next();
};


// Token Generation Utility
const generateToken = (user, modelName) => {
  return jwt.sign(
    { id: user._id, email: user.email, type: modelName, role: user.role || 'user' },
    process.env.JWT_SECRET,
    { expiresIn: process.env.JWT_EXPIRATION || '1h', issuer: 'UniversityApp', audience: 'university-users' }
  );
};



// Generate Refresh Token
const generateRefreshToken = (user, modelName) => {
  return jwt.sign(
    { id: user._id, email: user.email, type: modelName },
    process.env.REFRESH_TOKEN_SECRET,
    { expiresIn: '7d' }
  );
};



// Authentication Middleware
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
    if (error.name === 'TokenExpiredError') {
      return res.status(401).json({ message: 'Token expired' });
    }
    res.status(401).json({ message: 'Token is not valid' });
  }
};



// Error Handling Middleware
const errorHandler = (err, req, res, next) => {
  console.error(err);
  res.status(500).json({
    message: 'Internal server error',
    error: process.env.NODE_ENV === 'production' ? {} : err.message
  });
};



// Generic CRUD Routes Generator
const createCRUDRoutes = (Model, modelName, validationSchema) => {
  // Create User Route
  router.post(
    `/${modelName}`,
    logRequest,
    validateRequest(validationSchema),
    async (req, res) => {
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
          data: { id: newUser._id, name: newUser.name, email: newUser.email }
        });
      } catch (error) {
        res.status(500).json({
          message: `Error creating ${modelName}`,
          error: error.message
        });
      }
  });

  
  
  // Login Route
  router.post(
    `/${modelName}/login`,
    logRequest,
    validateRequest(loginValidationSchema),
    async (req, res) => {
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

        // Generate Tokens
        const token = generateToken(user, modelName);
        const refreshToken = generateRefreshToken(user, modelName);

        res.json({
          token,
          refreshToken,
          user: { id: user._id, name: user.name, email: user.email }
        });
      } catch (error) {
        res.status(500).json({
          message: `${modelName} login error`,
          error: error.message
        });
      }
  });

  
  
  // Refresh Token Route
  router.post(`/${modelName}/refresh-token`, async (req, res) => {
    const { refreshToken } = req.body;

    try {
      const decoded = jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET);
      const user = await Model.findById(decoded.id);

      if (!user) {
        return res.status(401).json({ message: 'Invalid refresh token' });
      }

      const newToken = generateToken(user, modelName);

      res.json({ token: newToken });
    } catch (error) {
      res.status(401).json({ message: 'Invalid refresh token' });
    }
  });



  // Get All Users Route
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



  // Get User by ID Route
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



  // Update User Route
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

  
  
  // Delete User Route
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



  // Global error handler
  router.use(errorHandler);

  return router;
};



// Export routes for each user type
module.exports = {
  studentRoutes: createCRUDRoutes(Student, 'student', studentValidationSchema),
  teacherRoutes: createCRUDRoutes(Teacher, 'teacher', teacherValidationSchema),
  cafeteriaManagerRoutes: createCRUDRoutes(CafeteriaManager, 'cafeteriamanager', cafeteriaManagerValidationSchema),
  clubManagerRoutes: createCRUDRoutes(ClubManager, 'clubmanager', clubManagerValidationSchema)
};