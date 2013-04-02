define [
  'backbone'
], (Backbone) ->

  class User extends Backbone.Model
    urlRoot: '/users'

    signIn: ->
      model = @
      @unset "errors"
      options = {}
      options.url = '/session'

      options.success = (res, status, xhr) ->
        model.set(model.parse(res, xhr), options)
        model.trigger 'sync', model, res, options

      options.error = Backbone.wrapError(options.error, model, options)

      (@sync || Backbone.sync).call(@, 'create', @, options)


    logOut: ->
      model = @
      @unset "errors"
      options = {}
      options.url = "/session"
      options.success = (res, status, xhr) ->
        model.clear()
        model._id = null
      options.error = (xhr) ->
        model.set({errors: $.parseJSON(xhr.responseText)})

      (@sync || Backbone.sync).call(@, 'delete', @, options)
