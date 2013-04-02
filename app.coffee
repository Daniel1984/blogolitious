express = require 'express'
fs = require 'fs'
coffee = require 'coffee-script'
Mongoose = require 'mongoose'
device = require 'express-device'
CookieStore = require 'cookie-sessions'
app = express()
appPath = "#{process.cwd()}/app"

Mongoose.createConnection('localhost', 'blogolitious')
Mongoose.connect("mongodb://localhost/blogolitious")

app.configure ->
  app.set('views', "#{__dirname}/app/views")
  app.set('view engine', 'jade')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use CookieStore(secret: '1q2w3e4r5t', session_key: '_blg')
  app.use(express.static("#{__dirname}/public"))
  #app.use(express.logger('dev')) 
  app.use(require('connect-less')(
    src: "#{__dirname}/app/assets"
    dst: "#{__dirname}/cache/less"
    compress: true
    force: true
  ))
  app.use(express.static("#{__dirname}/cache/less"))
  app.use device.capture() 
  app.use app.router
  app.use (err, req, res, next) ->
    res.json(422,err)

app.configure 'development', ->
  app.get(/.js$/, (req, res, next) ->
    script = req.originalUrl.substring(1, req.originalUrl.length - 3)
    try
      file = "app/assets/javascripts/#{script}.coffee"
      cs = fs.readFileSync "#{__dirname}/#{file}", "ascii"
      try
        js = coffee.compile cs
        res.header 'Content-Type', 'application/x-javascript'
        res.send(js, 200)
      catch e
        res.send("Coffee compile error in #{file}\n" + e.stack, {'Content-Type': 'text/plain'}, 500)
    catch e
      next()
   )
  app.use(express.static("#{__dirname}/app/assets/javascripts"))

require("#{appPath}/router/routes")(app)

port = process.env.PORT || 3000
app.listen port, ->
  console.log "Listening on #{port}"

module.exports = app
