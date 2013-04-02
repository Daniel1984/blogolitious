define [
  'backbone'
  'models/user'
  'text!templates/admin/register/show-view.html'
  'views/support/error-view'
], (Backbone, User, Template, ErrorView) ->
  class RegisterView extends Backbone.View
    tagName: 'form'
    className: 'form-horizontal'

    events:
      'submit': 'registerUser'

    initialize: (options) ->
      @template = _.template(Template)
      @user = options.user
      @user.on 'error', @handleError

    render: =>
      @$el.html(@template(@user.toJSON()))
      @$el.backboneLink(@user)
      @

    registerUser: (e) =>
      e.preventDefault()
      @user.save()

    handleError: (model, err) =>
      error = new ErrorView el: @el, error: err.responseText

    leave: =>
      @remove()
      @user.off 'error'
