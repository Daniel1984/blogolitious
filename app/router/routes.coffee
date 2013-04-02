require 'express'
appPath = "#{process.cwd()}/app"

homeController = require "#{appPath}/controllers/home"
userController = require "#{appPath}/controllers/users"
postController = require "#{appPath}/controllers/posts"
sessionController = require "#{appPath}/controllers/sessions"

module.exports = (app) ->
  app.post '/session', sessionController.create
  app.del '/session', sessionController.destroy
  
  app.get '/', homeController.blogIndex
  app.get '/admin', homeController.adminIndex

  app.post '/users', userController.create
  app.get '/users/:id', userController.find

  app.post '/posts', postController.create
  app.put '/posts/:id', postController.update
  app.del '/posts/:id', postController.delete
  app.get '/posts/:id', postController.show
  app.get '/posts', postController.find
