const conn = require('../lib/db.js')
const moment = require('moment')

function getActivities(id_user){
    return new Promise(function(resolve,reject){
        let sql = `
        select  COUNT(s.id_act) as count, s.id_user, s.id_act, a.type, a.name, DATE(s.timestamp) as date
        FROM stats s
        LEFT JOIN activities a ON s.id_act=a.id_act
        WHERE s.id_user = ? AND a.active = 1 AND s.active = 1
        group by date, id_act`
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
        select  COUNT(s.id_act) as count, s.id_user, s.id_act, a.type, a.name, DATE(s.timestamp) as date
        FROM stats s
        LEFT JOIN activities a ON s.id_act=a.id_act
        WHERE s.id_user = ? AND s.id_act = ? AND a.active = 1 AND s.active = 1
        group by date, id_act`
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
                console.log(err)
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
        WHERE id_user = ? AND id_act = ?
        LIMIT 1`
        conn.query(sql,[id_user,id_act],function(err,results,fields){
            if(err){
                reject({
                    status:'Failure',
                    message:'deleteActivity DB query failure'
                })
            } else{
                if(!results.changedRows){
                    reject({
                        status:'Failure',
                        message:'Activity ID not found'
                    })
                } else{
                    resolve({
                        status:'Success',
                        id_act: id_act
                    })
                }
            }
        })
    })
}
function postActivity(id_user,id_act,date,count,override){
    dateLong = moment(date).utc().format("YYYY-MM-DD HH:mm:ss")
    dateShort = moment(date).utc().format("YYYY-MM-DD")
    let active = 1
    if(override){active =0}
    return new Promise(function(resolve,reject){
        let sql1 = `
        UPDATE stats
        SET active = ?
        WHERE id_user = ? AND id_act = ? AND DATE(timestamp) = ?`
        conn.query(sql1,[active,id_user,id_act,dateShort],function(err,results,fields){
            if(err){
                console.log(err)
                reject({
                    status:'Failure',
                    message:'postActivity failed DB query'
                })
            } else {
                let arrPromises = []
                for(i = 0; i < count;i++){
                    let temp = new Promise(function(resolve,reject){
                        let sql = `
                        INSERT INTO stats (id_user,id_act,timestamp)
                        VALUES (?,?,?)`
                        conn.query(sql,[id_user,id_act,dateLong],function(err,results,fields){
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
                    arrPromises.push(temp)
                }
                let arrResults = Promise.all(arrPromises)
                arrResults.then(function(data){
                    resolve ({
                        status:'Success',
                        id_act:id_act,
                        count:count,
                        date: dateShort,
                        override: override
                    })
                })
                .catch(function(data){
                    reject({
                        status:'Failure',
                        message:'Unable to update count on activities'
                    })
                })
            }
        })
    })
}
function deleteActivity(id_user,id_act,date){
    dateShort = moment(date).utc().format("YYYY-MM-DD")
    return new Promise(function(resolve,reject){
        let sql = `
        UPDATE stats
        SET active = 0
        WHERE id_user = ? AND id_act = ? AND DATE(timestamp) = ?`
        conn.query(sql,[id_user,id_act,dateShort],function(err,results,fields){
            if(err){
                reject({
                    status:'Failure',
                    message:'postActivity failed DB query'
                })
            } else {
                resolve({
                    status:'Success',
                    id_act:id_act,
                    date:dateShort
                })
            }
        })
    })
}
module.exports = {
    getActivities: getActivities,
    getActivity: getActivity,
    createActivity: createActivity,
    putActivity:putActivity,
    deleteActivity:deleteActivity,
    postActivity:postActivity,
    deleteActivity:deleteActivity
}