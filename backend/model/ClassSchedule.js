const mongoose = require('mongoose');

const ClassScheduleSchema = new mongoose.Schema({
  name: String,
  designation: String,
  email: String,
  phone: String,
  whatsapp: String,
  image: String,
}
);

module.exports = mongoose.model('ClassSchedule', ClassScheduleSchema);