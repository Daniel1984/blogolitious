appPath = "#{process.cwd()}/app"
Post = require "#{appPath}/models/user"
User = require "#{appPath}/models/user"

module.exports.adminIndex = (req, res, next) ->
  tmp = 'admin'
  css = 'admin/main'
  if req.session?._id
    User.findOne _id: req.session._id, (err, user) ->
      user.password = undefined
      serveContent(req, res, tmp, css, null, user)
  else
    serveContent(req, res, tmp, css, null, null)


serveContent = (req, res, tmp, css, session = null, user = null) ->
  if req.query.mobile == 'true' || req.device.type == 'phone'
    mobile = true
  else
    mobile = false
  res.render tmp,
    title: 'Blogolitious'
    stylesheet: css
    device: mobile
    user: user
    session: session
