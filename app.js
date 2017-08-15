const express = require('express')
const app = express()
const bodyParser = require('body-parser')

const Authorize = require('./middleware/authorization.js')

//My routes
const indexRouter = require('./routes/indexRoute')
const aboutRouter = require('./routes/aboutRoute')
const apiRouter = require('./routes/apiRoute')
const loginRoute = require('./routes/loginRoute')

//Basic body parser settings
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: false }))

//Use the routes files.
app.use('/', indexRouter);
app.use('/1/api',loginRoute)
app.use('/1/api',Authorize,apiRouter)

app.listen(3000, function(){
  console.log("App running on port 3000")
})