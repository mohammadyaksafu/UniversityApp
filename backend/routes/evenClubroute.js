const express = require('express');
const router = express.Router();
const { Event, Club } = require('../model/eventClubModel'); 

// Create a new Event
router.post('/events', async (req, res) => {
  try {
    const newEvent = new Event(req.body);
    await newEvent.save();
    res.status(201).json(newEvent);
  } catch (error) {
    res.status(400).json({ message: 'Error creating event', error: error.message });
  }
});

// Get all Events
router.get('/events', async (req, res) => {
  try {
    const events = await Event.find();
    res.json(events);
  } catch (error) {
    res.status(500).json({ message: 'Error fetching events', error: error.message });
  }
});

// Create a new Club
router.post('/clubs', async (req, res) => {
  try {
    const newClub = new Club(req.body);
    await newClub.save();
    res.status(201).json(newClub);
  } catch (error) {
    res.status(400).json({ message: 'Error creating club', error: error.message });
  }
});

// Get all Clubs
router.get('/clubs', async (req, res) => {
  try {
    const clubs = await Club.find();
    res.json(clubs);
  } catch (error) {
    res.status(500).json({ message: 'Error fetching clubs', error: error.message });
  }
});

// Update an Event
router.put('/events/:id', async (req, res) => {
  try {
    const updatedEvent = await Event.findByIdAndUpdate(req.params.id, req.body, { new: true });
    if (!updatedEvent) {
      return res.status(404).json({ message: 'Event not found' });
    }
    res.json(updatedEvent);
  } catch (error) {
    res.status(400).json({ message: 'Error updating event', error: error.message });
  }
});

// Update a Club
router.put('/clubs/:id', async (req, res) => {
  try {
    const updatedClub = await Club.findByIdAndUpdate(req.params.id, req.body, { new: true });
    if (!updatedClub) {
      return res.status(404).json({ message: 'Club not found' });
    }
    res.json(updatedClub);
  } catch (error) {
    res.status(400).json({ message: 'Error updating club', error: error.message });
  }
});

// Delete an Event
router.delete('/events/:id', async (req, res) => {
  try {
    const deletedEvent = await Event.findByIdAndDelete(req.params.id);
    if (!deletedEvent) {
      return res.status(404).json({ message: 'Event not found' });
    }
    res.json({ message: 'Event deleted successfully', data: deletedEvent });
  } catch (error) {
    res.status(500).json({ message: 'Error deleting event', error: error.message });
  }
});

// Delete a Club
router.delete('/clubs/:id', async (req, res) => {
  try {
    const deletedClub = await Club.findByIdAndDelete(req.params.id);
    if (!deletedClub) {
      return res.status(404).json({ message: 'Club not found' });
    }
    res.json({ message: 'Club deleted successfully', data: deletedClub });
  } catch (error) {
    res.status(500).json({ message: 'Error deleting club', error: error.message });
  }
});

module.exports = router;
