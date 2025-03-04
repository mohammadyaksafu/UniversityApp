const express = require('express');
const router = express.Router();
const ClassSchedule = require('../model/ClassSchedule');

 router.get('/', async (req, res) => {
    const schedules = await ClassSchedule.find();
    res.json(schedules);
  });
  
  router.post('/', async (req, res) => {
    const newSchedule = new ClassSchedule(req.body);
    await newSchedule.save();
    res.json(newSchedule);
  });
  
  router.delete('/:id', async (req, res) => {
    try {
      await ClassSchedule.findByIdAndDelete(req.params.id);
      res.json({ message: 'Schedule deleted successfully' });
    } catch (error) {
      res.status(500).json({ error: 'Error deleting schedule' });
    }
  });

module.exports = router;