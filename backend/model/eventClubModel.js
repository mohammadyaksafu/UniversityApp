const mongoose = require('mongoose');

// Event Schema
const eventSchema = new mongoose.Schema({
    title: { type: String, required: true },
    date: { type: String, required: true },
    time: { type: String, required: true },
    location: { type: String, required: true },
    organizer: { type: String, required: true },
    isOpen: { type: Boolean, default: true },
  });
  
  // Club Schema
  const clubSchema = new mongoose.Schema({
    name: { type: String, required: true },
    description: { type: String, required: true },
    isMember: { type: Boolean, default: false },
  });
  
  const Event = mongoose.model('Event', eventSchema);
  const Club = mongoose.model('Club', clubSchema);
  
  module.exports = { Event, Club };