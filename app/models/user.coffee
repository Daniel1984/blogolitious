Mongoose = require "mongoose"
bcrypt = require 'bcrypt'

passLength = (v) ->
  return v?.length > 6

jsInject = (str) ->
  return false if /script|\$/i.test(str)

userSchema = new Mongoose.Schema
  user_name: type: String, unique: true, required: true, validate: [jsInject, "don't even think"]
  email: type: String, unique: true, required: true, validate: [jsInject, "don't even think!"]
  password: type: String, required: true, validate: [passLength, "min 6 characters"]
  admin: type: Boolean, default: false
  created_at: type: Date
  updated_at: type: Date, default: Date.now

userSchema.pre 'save', (next) ->
  user = this
  bcrypt.hash user.password, 8, (err, hash) ->
    return next(err) if err
    user.password = hash
    next()

userSchema.methods.comparePasswords = (candidatePass, hash, cb) ->
  bcrypt.compare candidatePass, hash, (err, match) ->
    return cb(err, null) if err
    cb(null, match)

module.exports = Mongoose.model('user', userSchema)
