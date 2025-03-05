const mongoose = require('mongoose');

const ClassScheduleSchema = new mongoose.Schema({
  subject: {
    type: String,
    required: true
  },
  time: {
    type: String,
    required: true
  },
  faculty: {
    type: String,
    required: true
  },
  room: {
    type: String,
    required: true
  },
  department: {
    type: String,
    required: true
  },

});

module.exports = mongoose.model('ClassSchedule', ClassScheduleSchema);
