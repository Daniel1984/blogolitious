define [
  'backbone'
  'views/admin/navbar/show-view'
  'collections/navbar-items'
  'text!templates/admin/site/layout-view.html'
], (Backbone, NavbarView, NavbarItems, Template) ->
  
  class AdminSite extends Backbone.View
    className: 'page'

    initialize: (options) ->
      @template = _.template(Template)
      @user = options.user
      @user.on 'change:created_at', @onUserChange
      @navItems = new NavbarItems([], {user: @user})
      @navItems.on 'active:view:changed', @displayActiveView
      @navItems.loadItems()
      
    render: =>
      @siteLayout()
      @navbar()
      @checkForActiveView()
      @

    onUserChange: =>
      @navbar()
      @checkForActiveView()

    siteLayout: =>
      @$el.append(@template)
      
    navbar: =>
      @navbarView?.leave()
      @navbarView = new NavbarView collection: @navItems, user: @user
      @$('.navbar').append(@navbarView.render().el)

    checkForActiveView: =>
      if @user.has 'created_at'
        @navItems.each(@displayActiveView)
      else
        @activeView?.leave()

    displayActiveView: (model) =>
      if model.get 'viewActive'
        @activeView?.leave()
        View = model.get 'view'
        @activeView = new View(model: model, user: @user)
        @$('.content').append(@activeView.render().el)
