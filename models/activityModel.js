const conn = require('../lib/db.js')

function getActivities(id_user){
    return new Promise(function(resolve,reject){
        let sql = `
        select  COUNT(s.id_act) as Count, s.id_user, s.id_act, a.type, a.name, DATE(s.timestamp) as DATE
        FROM stats s
        LEFT JOIN activities a ON s.id_act=a.id_act
        WHERE s.id_user = ? AND a.active = 1
        group by DATE, id_act`
        conn.query(sql,[id_user],function(err,results,fields){
            if(err){
                reject({
                    status:'Failure',
                    message: 'getActivities had a DB error'
                })
            } else{
                resolve ({
                    status:'Success',
                    activities: results
                })
            }
        })
    })
}
function getActivity(id_user,id_act){
    return new Promise(function(resolve,reject){
        let sql = `
        select  COUNT(s.id_act) as Count, s.id_user, s.id_act, a.type, a.name, DATE(s.timestamp) as DATE
        FROM stats s
        LEFT JOIN activities a ON s.id_act=a.id_act
        WHERE s.id_user = ? AND s.id_act = ? AND a.active = 1
        group by DATE, id_act`
        conn.query(sql,[id_user,id_act],function(err,results,fields){
            if(err){
                reject({
                    status:'Failure',
                    message: 'getActivities had a DB error'
                })
            } else{
                resolve ({
                    status:'Success',
                    activities: results
                })
            }
        })
    })
}
function createActivity(id_user,act_name,act_type){
    return new Promise(function(resolve,reject){
        let sql = `
        INSERT INTO activities (name,type,id_user)
        VALUES (?,?,?)`
        conn.query(sql,[act_name,act_type,id_user],function(err,results,fields){
            if(err){
                reject({
                    status:'Failure',
                    message: 'createActivity had a DB error'
                })
            } else {
                resolve ({
                    status:'Success',
                    activity: {
                        id_act:results.insertId,
                        name:act_name,
                        type:act_type,
                        id_user: id_user
                    }
                })
            }
        })
    })
}
function putActivity(id_user,id_act){
    return new Promise(function(resolve,reject){
        let sql = `
        INSERT INTO stats (id_user,id_act)
        VALUES (?,?)`
        conn.query(sql,[id_user,id_act],function(err,results,fields){
            if(err){
                reject ({
                    status:'Failure',
                    message:'putActivity db error'
                })
            } else {
                resolve ({
                    status:'Success',
                    id_act:id_act
                })
            }
        })
    })
}
function deleteActivity(id_user,id_act){
    return new Promise(function(resolve,reject){
        let sql = `
        UPDATE activities
        SET active = 0
        WHERE id_user = ? AND id_act = ?`
    })
}
module.exports = {
    getActivities: getActivities,
    getActivity: getActivity,
    createActivity: createActivity,
    putActivity:putActivity
}