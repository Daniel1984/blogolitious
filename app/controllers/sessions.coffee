appPath = "#{process.cwd()}/app"
User = require "#{appPath}/models/user"

module.exports.create = (req, res, next) ->
  if !req.body.user_name || !req.body.password
    res.json(401, base: 'Please enter your login details')
  else
    User.findOne user_name: req.body.user_name, (err, user) ->
      return res.json(401, base: 'No match found. Try again!') if user == null
      user.comparePasswords req.body.password, user.password, (err, match) ->
        return res.json(401, base: 'Invalid user name or password') if !match
        req.session = {_id: user._id}
        user.password = undefined
        res.json(user, 200)

module.exports.destroy = (req, res, next) ->
  req.session = undefined
  res.send('')
