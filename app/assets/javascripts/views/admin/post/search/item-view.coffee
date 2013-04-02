define [
  'backbone'
  'text!templates/admin/post/search/item-view.html'
  'views/support/modal'
], (Backbone, Template, Modal) ->
  class ItemView extends Backbone.View
    tagName: 'tr'
    events:
      'click #edit-post-btn': 'editPost'
      'click #delete-post-btn': 'deletePost'

    initialize: (options) ->
      @model.on 'destroy', @leave
      @template = _.template(Template)

    render: =>
      @$el.html(@template(post: @model.toJSON()))
      @

    editPost: (e) =>
      e.preventDefault()
      @model.trigger 'update:post', @model

    deletePost: (e) =>
      e.preventDefault()
      modal = new Modal model: @model, action: 'delete', title: 'Attention', body: "<div class='alert alert-error'><h5>You are about to delete your post! Are you sure you want to do this?</h5></div>"
      @$el.append(modal)

    leave: =>
      @model.off 'destroy'
      @remove()
