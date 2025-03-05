const express = require('express');
const router = express.Router();
const Faculty = require('../model/faculty.model'); 


router.post('/', async (req, res) => {
  try {
    const { name, email, phone, whatsapp, office, department, image } = req.body;

    
    if (!name || !email || !phone || !whatsapp || !office || !department || !image) {
      return res.status(400).json({ message: 'All fields are required' });
    }


    const newFaculty = new Faculty({
      name,
      email,
      phone,
      whatsapp,
      office,
      department,
      image,
    });

    await newFaculty.save();

    res.status(201).json({ message: 'Faculty contact added successfully', data: newFaculty });
  } catch (error) {
    console.error('Error adding faculty contact:', error);
    res.status(500).json({ message: 'Failed to add faculty contact', error: error.message });
  }
});


router.get('/', async (req, res) => {
  try {
    const facultyContacts = await Faculty.find();
    // Directly return the array instead of an object with data
    res.status(200).json(facultyContacts);
  } catch (error) {
    console.error('Error fetching faculty contacts:', error);
    res.status(500).json({ message: 'Failed to fetch faculty contacts', error: error.message });
  }
});

// Get a specific faculty contact by ID
router.get('/:id', async (req, res) => {
  try {
    const facultyContact = await Faculty.findById(req.params.id);
    if (!facultyContact) {
      return res.status(404).json({ message: 'Faculty contact not found' });
    }
    res.status(200).json({ message: 'Faculty contact fetched successfully', data: facultyContact });
  } catch (error) {
    console.error('Error fetching faculty contact:', error);
    res.status(500).json({ message: 'Failed to fetch faculty contact', error: error.message });
  }
});


router.delete('/:id', async (req, res) => {
  try {
    const facultyContact = await Faculty.findByIdAndDelete(req.params.id);
    if (!facultyContact) {
      return res.status(404).json({ message: 'Faculty contact not found' });
    }
    res.status(200).json({ message: 'Faculty contact deleted successfully', data: facultyContact });
  } catch (error) {
    console.error('Error deleting faculty contact:', error);
    res.status(500).json({ message: 'Failed to delete faculty contact', error: error.message });
  }
});

module.exports = router;