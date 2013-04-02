define [
  'backbone'
  'is!mobile?text!templates/admin/login/show-mobile.html:text!templates/admin/login/show.html'
  'views/support/error-view'
], (Backbone, Template, ErrorView) ->
 
  class LoginShowView extends Backbone.View
    events:
     'submit': 'login'

    initialize: (options) ->
      @template = _.template(Template)
      @user = options.user
      @user.on 'error', @handleError

    render: =>
      @$el.html(@template(@user.toJSON()))
      @$('form').backboneLink(@user)
      @

    login: (e) =>
      e.preventDefault()
      @user.signIn()

    handleError: (model, err) =>
      error = new ErrorView el: @el, error: err.responseText

    leave: =>
      @remove()
      @user.off 'error'
