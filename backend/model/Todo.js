const mongoose = require('mongoose');

const TodoSchema = new mongoose.Schema({
    title: String,
    sesion: String,
    depertmentcode:String,
    dueDate: Date,
    type: { type: String, enum: ['Assignment', 'Exam'] },
  });
  
  module.exports = mongoose.model('Todo', TodoSchema);