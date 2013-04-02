define [
  'backbone'
  'views/admin/navbar/list-view'
  'text!templates/admin/navbar/show-view.html'
  'views/support/modal'
  'views/admin/login/show-view'
  'views/admin/register/show-view'
], (Backbone, NavListView, Template, ModalView,  LoginView, RegisterView) ->

  class NavbarShowView extends Backbone.View
    className: 'navbar-inner'
    events:
      'click .signin': 'signin'
      'click .register': 'register'
      'click .logout': 'logOut'

    initialize: (options) ->
      @template = _.template(Template)
      @items = options.collection
      @user = options.user

    render: =>
      @$el.html(@template(user: @user.toJSON()))
      @renderItems()
      @

    renderItems: =>
      @navItemsList = new NavListView collection: @items
      @$('.menu-items').append(@navItemsList.render().el)

    signin: (e) =>
      e.preventDefault()
      @loginView?.leave()
      @loginView = new LoginView user: @user
      modal?.leave()
      modal = new ModalView model: @user, body: @loginView, title: 'Sign In', action: 'signin'
      @$el.append(modal)

    register: (e) =>
      e.preventDefault()
      @registerView?.leave()
      @registerView = new RegisterView user: @user
      modal?.leave()
      modal = new ModalView model: @user, body: @registerView, title: 'Register', action: 'save'
      @$el.append(modal)

    logOut: (e) =>
      e.preventDefault()
      @user.logOut()

    leave: =>
      @remove()
