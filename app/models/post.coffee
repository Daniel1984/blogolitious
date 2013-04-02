Mongoose = require "mongoose"

commentSchema = new Mongoose.Schema
  title: type: String, required: true
  body: type: String
  date: type: Date, default: Date.now

postSchema = new Mongoose.Schema
  category: type: String, required: true
  title: type: String, required: true
  author: type: String, required: true
  lead: type: String
  body: type: String 
  published: type: Boolean, default: false
  comments_enabled: type: Boolean, default: false
  comments: [commentSchema]
  updated_at: type: Date, default: Date.now
  created_at: type: Date

PostModel = Mongoose.model('post', postSchema)
CommentModel = Mongoose.model('comment', commentSchema)

module.exports.create = (post, cb) ->
  post.created_at = Date.now()
  PostModel(post).save (err, post) ->
    cb(err, post)

module.exports.index = (query, cb) ->
  PostModel.find search(query), (err, posts) ->
    cb(err, posts)
search = (query) ->
  switch query
    when 'false' then published: false
    when 'true' then published: true
    else {}
 
module.exports.update = (post, cb) ->
  id = post._id
  delete post._id
  PostModel.update _id: id, post, (err, data) ->
    cb(err, data)

module.exports.delete = (id, cb) ->
  PostModel.remove _id: id, (err) ->
    cb(err)
