const conn = require('../lib/db.js')

function getActivities(id_user){
    return new Promise(function(resolve,reject){
        let sql = `
        select  COUNT(s.id_act) as Count, s.id_user, s.id_act, a.type, a.name, DATE(s.timestamp) as DATE
        FROM stats s
        LEFT JOIN activities a ON s.id_act=a.id_act
        WHERE s.id_user = ?
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

module.exports = {
    getActivities: getActivities
}