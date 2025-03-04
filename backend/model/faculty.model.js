const mongoose = require('mongoose');

const facultySchema = new mongoose.Schema({
  name: { type: String},
  email: { type: String },
  phone: { type: String },
  whatsapp: { type: String },
  office: { type: String },
  department: { type: String },
  image: { type: String },
});

const Faculty = mongoose.model('Faculty', facultySchema);

module.exports = Faculty;