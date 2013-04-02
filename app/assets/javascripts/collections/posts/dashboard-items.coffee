define [
  'backbone'
  'models/post/dashboard-item'
  'views/admin/post/new/show-view'
  'views/admin/post/search/show-view'
], (Backbone, DashboardItem, PostView, ShowView) ->

  class DashboardItems extends Backbone.Collection
    model: DashboardItem

    initialize: (models, options) ->

    viewChanged: (changedItem) =>
      @each( (item) -> 
        if item != changedItem and item.get('viewActive') 
          item.set(viewActive: false)
      )

    loadItems: =>
      @reset([
        {view: PostView, viewActive: true, title: 'Create Post', icon: 'icon-pencil'}
        {view: ShowView, viewActive: false, title: 'Edit Post', icon: 'icon-edit'}
      ])
