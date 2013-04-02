define [
  'backbone'
  'models/post'
  'collections/posts/dashboard-items'
  'views/admin/post/new/show-view'
  'views/admin/dashboard/list-view'
  'text!templates/admin/post/show-view.html'
], (Backbone, PostModel, DashboardItems, Post, Dashboard, Template) ->

  class PostView extends Backbone.View
    className: 'row'

    initialize: (options) ->
      @template = _.template(Template)
      @user = options.user
      @post = new PostModel()
      @dashboardItems = new DashboardItems([], {})
      @dashboardItems.on 'active:view:changed', @displayActiveView
      @dashboardItems.loadItems()

    render: =>
      @$el.html(@template)
      @dashboard()
      @checkForActiveView()
      @

    dashboard: =>
      @dashboard = new Dashboard collection: @dashboardItems
      @$('.dashboard').append(@dashboard.render().el)

    checkForActiveView: =>
      @dashboardItems.each(@displayActiveView)

    displayActiveView: (model) =>
      if model.get 'viewActive'
        @activeView?.leave()
        View = model.get 'view'
        @activeView = new View(model: model)
        @$('.post-content').append(@activeView.render().el)

    leave: =>
      @dashboardItems.off()
      @activeView?.leave()
      @dashboard.leave()
      @remove()
