const express = require('express');
const router = express.Router();
const aboutModel = require('../models/aboutModel.js')

router.get('/', function (req, res) {
  res.json({
    message:'This is an app by Jase Cutler for an assignment with The Iron Yard, Las Vegas. Hire me.'
  });
});

module.exports = router;