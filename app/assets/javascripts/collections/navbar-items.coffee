define [
  'backbone'
  'views/admin/post/show-view'
  'views/admin/video/show-view'
  'views/admin/pictures/show-view'
  'models/navbar-item'
], (Backbone, PostView, VideoView, PicturesView, NavbarItem) ->

  class NavbarItems extends Backbone.Collection
    model: NavbarItem

    initialize: (models, options) ->
      @user = options.user

    viewChanged: (changedItem) =>
      @each( (item) -> 
        if item != changedItem and item.get('viewActive') 
          item.set(viewActive: false)
      )

    loadItems: =>
      @reset([
        {view: PostView, viewActive: true, title: 'Posts'}
        {view: VideoView, viewActive: false, title: 'Videos'}
        {view: PicturesView, viewActive: false, title: 'Pictures'}
      ])
