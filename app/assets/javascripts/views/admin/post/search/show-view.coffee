define [
  'backbone'
  'text!templates/admin/post/search/show-view.html'
  'views/admin/post/search/list-view'
  'collections/posts'
  'views/admin/post/edit/show-view'
  'views/support/modal'
], (Backbone, Template, ListView, Posts, PostEditView, ModalView) ->

  class SearchView extends Backbone.View
    tagName: 'form'
    className: 'form-horizontal'

    events:
      'click #search-post-btn': 'searchPosts'

    initialize: (options) ->
      @template = _.template(Template)
      @posts = new Posts()
      @posts.on 'reset', @render
      @posts.on 'update:post', @updatePost

    updatePost: (post) =>
      @postView?.leave()
      @postView = new PostEditView post: post
      modal?.leave()
      modal = new ModalView model: post, body: @postView, title: 'Edit Post', action: 'edit-post'
      @$el.append(modal)

    render: =>
      @$el.html(@template)
      @list()
      @

    list: =>
      @listView?.leave()
      @listView = new ListView collection: @posts
      @$el.append(@listView.render().el)

    searchPosts: (e) =>
      e.preventDefault()
      @posts.fetch
        data:
          published: @$('.published').val()

    leave: =>
      @remove()
      @posts.off 'reset'
      @posts.off 'update:post'
