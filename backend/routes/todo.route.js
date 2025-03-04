const express = require('express');
const router = express.Router();
const Todo = require('../model/Todo');

router.get('/', async (req, res) => {
  const todos = await Todo.find();
  res.json(todos);
});

router.post('/', async (req, res) => {
  const newTodo = new Todo(req.body);
  await newTodo.save();
  res.json(newTodo);
});

router.delete('/:id', async (req, res) => {
    try {
      await ClassSchedule.findByIdAndDelete(req.params.id);
      res.json({ message: 'TodoList deleted successfully' });
    } catch (error) {
      res.status(500).json({ error: 'Error deleting  Todolist' });
    }
  });

module.exports = router;