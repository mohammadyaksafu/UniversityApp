const mongoose = require('mongoose');

const baseUserSchema = {
  name: { type: String, required: true,trim: true},
  email: { type: String, required: true, unique: true,lowercase: true,trim: true},
  password: { type: String, required: true },
  profileImage: { type: String, default: '' },
  contactNumber: { type: String },
  isActive: { type: Boolean, default: true },
  createdAt: { type: Date, default: Date.now }
};

// Student Model
const studentSchema = new mongoose.Schema({
  ...baseUserSchema,
  studentId: { type: String, required: true, unique: true },
  department: { type: String, required: true },
  semester: { type: Number, required: true },
  enrolledCourses: [ String,String],
});



// Teacher Model
const teacherSchema = new mongoose.Schema({
  ...baseUserSchema,
  employeeId: { type: String, required: true, unique: true  },
  department: {  type: String, required: true },
  designation: { type: String, enum: ['Assistant Professor', 'Associate Professor', 'Professor', 'Lecturer'] },
  courses: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Course' }],
  officeLocation: {  type: String }
});



// Cafeteria Manager Model
const cafeteriaManagerSchema = new mongoose.Schema({
  ...baseUserSchema,
  managerId: {  type: String,  required: true,  unique: true },
  shiftTiming: { start: String, end: String },
  responsibleFor: { type: String, enum: ['Main Cafeteria', 'Staff Cafeteria', 'Student Cafeteria'] }
});



// Club Manager Model
const clubManagerSchema = new mongoose.Schema({
  ...baseUserSchema,
  managerId: { type: String, required: true, unique: true },
  clubName: { type: String, required: true },
  clubType: { type: String, enum: ['Technical', 'Cultural', 'Sports', 'Academic', 'Arts'] },
  clubMembers: [{  type: mongoose.Schema.Types.ObjectId, ref: 'Student'}]
});

const Student = mongoose.model('Student', studentSchema);
const Teacher = mongoose.model('Teacher', teacherSchema);
const CafeteriaManager = mongoose.model('CafeteriaManager', cafeteriaManagerSchema);
const ClubManager = mongoose.model('ClubManager', clubManagerSchema);

module.exports = {Student, Teacher, CafeteriaManager, ClubManager};
