const express = require('express')
const router = express.Router()
const User = require('../models/userModel.js')

router.post('/register', function(req,res,next){
    username = req.body.username
    password = req.body.password
    displayName = req.body.displayName
    if(!displayName){displayName = username}
    registration = User.createUser(username, password, displayName)
    registration.then(function(data){
        console.log(data)
        res.json(data)
    })
    .catch(function(data){
        console.log(data)
        res.json(data)
    })
})
router.post('/gettoken',function(req,res,next){
    username = req.body.username
    password = req.body.password
    console.log(req.body.username)
    newToken = User.getNewToken(username,password)
    newToken.then(function(data){
        console.log(data)
        res.json(data)
    })
    .catch(function(data){
        console.log(data)
        res.json(data)
    })
})
module.exports = router