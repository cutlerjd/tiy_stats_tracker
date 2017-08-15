const express = require('express');
const router = express.Router();

router.get('/', function (req, res) {
  res.json({
    message:'Home directory'
  });
});

module.exports = router;