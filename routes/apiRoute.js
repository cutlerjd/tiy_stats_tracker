const express = require('express');
const router = express.Router()

const Activity = require('../models/activityModel')
// GET	/activities	Show a list of all activities I am tracking, and links to their individual pages
router.get('/activities', function(req,res,next){
    let activity = Activity.getActivities(res.locals.id_user)
    activity.then(function(data){
        res.json(data)
    })
    .catch(function(data){
        res.json(data)
    })
})
// POST	/activities	Create a new activity for me to track.
router.post('/activities', function(req,res,next){
    let act_name = req.body.name
    let act_type = req.body.type
    let activity = Activity.createActivity(res.locals.id_user,act_name,act_type)
    activity.then(function(data){
        res.json(data)
    })
    .catch(function(data){
        res.json(data)
    })
})
// GET	/activities/{id}	Show information about one activity I am tracking, and give me the data I have recorded for that activity.
router.get('/activities/:id', function(req,res,next){
    let id_act = req.params.id
    let activity = Activity.getActivity(res.locals.id_user,id_act)
    activity.then(function(data){
        res.json(data)
    })
    .catch(function(data){
        res.json(data)
    })
})
// PUT	/activities/{id}	Update one activity I am tracking, changing attributes such as name or type. Does not allow for changing tracked data.
router.put('/activities/:id', function(req,res,next){
    let id_act = req.params.id
    let activity = Activity.putActivity(res.locals.id_user,id_act)
    activity.then(function(data){
        res.json(data)
    })
    .catch(function(data){
        res.json(data)
    })
})
// DELETE	/activities/{id}	Delete one activity I am tracking. This should remove tracked data for that activity as well.
// POST	/activities/{id}/stats	Add tracked data for a day. The data sent with this should include the day tracked. You can also override the data for a day already recorded.
// DELETE	/stats/{id}	Remove tracked data for a day.

module.exports = router;