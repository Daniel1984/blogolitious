appPath = "#{process.cwd()}/app"

Post = require "#{appPath}/models/post"

module.exports.find = (req, res) ->
  Post.index req.query.published, (err, posts) ->
    return next(err) if err
    res.json(posts, 200)


module.exports.create = (req, res, next) ->
  Post.create req.body, (error, post) ->
    return next(error) if error
    res.json(post, 200)

module.exports.update = (req, res, next) ->
  Post.update req.body, (err, post) ->
    return next(err) if err
    res.json(post, 200)

module.exports.delete = (req, res, next) ->
  Post.delete req.params.id, (err) ->
    return next(err) if err
    res.json('', 200)
