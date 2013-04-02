appPath = "#{process.cwd()}/app"

User = require "#{appPath}/models/user"

module.exports.create = (req, res, next) ->
  usr = req.body
  usr.created_at = Date.now()
  new User(usr).save (err, user) ->
    return next(err) if err
    user.password = undefined
    req.session = {_id: user._id}
    res.json(user, 200)
