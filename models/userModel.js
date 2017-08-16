const conn = require('../lib/db.js')
const bcrypt = require('bcryptjs');
const uuid = require('uuid')

function createUser(username, password, displayName) {
    console.log(username, password, displayName)
    return new Promise(function (resolve, reject) {
        const hash = bcrypt.hash(password, 8).then(function (hash) {
            let sql = `
            INSERT INTO users (username,displayName,passwordHash)
            VALUES (?,?,?)
            `
            conn.query(sql, [username, displayName, hash], function (err, results, fields) {
                if (err) {
                    reject({
                        status: 'Failure',
                        message: 'createUser DB Failure'
                    })
                } else {
                    let token = uuid()
                    let sql2 = `
                    INSERT INTO tokens (token,id_user)
                    VALUES (?,?)`
                    conn.query(sql2, [token, results.insertId], function (err, results, fields) {
                        if (err) {
                            reject({
                                status: 'Failure',
                                message: 'createUser failed to store token in DB'
                            })
                        } else {
                            resolve({
                                status: 'Success',
                                userInfo: {
                                    username: username,
                                    displayName: displayName,
                                    token: token
                                }
                            })
                        }
                    })
                }
            })
        })
            .catch(function (data) {
                console.log(data)
                reject({
                    status: 'Failure',
                    message: 'createUser failed to create hash'
                })
            })
    })
}

function getNewToken(username, password) {
    console.log(username)
    return new Promise(function (resolve, reject) {
        let sql = `
        SELECT *
        FROM users
        WHERE username = ?`
        conn.query(sql, [username], function (err, results, fields) {
            if (err) {
                reject({
                    status: 'Failure',
                    message: 'getNewToken failed first DB query'
                })
            } else {
                if(!results[0]){
                    reject({
                        status:'Failure',
                        message:'Invalid credentials'
                    })
                } else {
                passwordCompare = bcrypt.compare(password, results[0].passwordHash)
                    .then(function () {
                        let token = uuid()
                        let sql2 = `
                                    INSERT INTO tokens (token,id_user)
                                    VALUES (?,?)`
                        conn.query(sql2, [token, results[0].id_user], function (err, results2, fields) {
                            if (err) {
                                reject({
                                    status: 'Failure',
                                    message: 'getNewToken failed to store token in DB'
                                })
                            } else {
                                resolve({
                                    status: 'Success',
                                    userInfo: {
                                        username: username,
                                        displayName: results[0].displayName,
                                        token: token
                                    }
                                })
                            }
                        })
                    })
                    .catch(function(){
                        reject({
                            status:'Failure',
                            message:'Invalid credentials'
                        })
                    
                    })
                }
            }
        })
    })
}
function verifyToken(token){
    return new Promise(function(resolve,reject){
        let sql = `
        SELECT *
        FROM tokens
        WHERE token = ? AND active=1`
        conn.query(sql,[token],function(err,results,fields){
            if(err){
                reject({
                    status:'Failure',
                    message:'verifyToken failed db query'
                })
            }else {
                if(!results[0]){
                    reject({
                        status:'Failure',
                        message:'Valid token not present'
                    })
                }else{
                    resolve(results[0])
                }
            }
        })
    })
}

module.exports = {
    createUser: createUser,
    getNewToken: getNewToken,
    verifyToken:verifyToken
}