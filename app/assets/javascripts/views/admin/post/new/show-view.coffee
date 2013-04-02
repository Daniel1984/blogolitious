define [
  'backbone'
  'models/post'
  'views/support/wysiwyg'
  'text!templates/admin/post/new/show-view.html'
  'views/support/error-view'
], (Backbone, Post, TextEditorView, Template, ErrorView) ->
  class NewPostView extends Backbone.View
    tagName: 'form'
    className: 'form-horizontal'
    
    events:
      'submit': 'submitData'

    initialize: (options) ->
      @template = _.template(Template)
      @post = new Post()
      @post.on 'error', @handleError
      @post.on 'sync', @handleSuccess
      
    render: =>
      @$el.html(@template(@post.toJSON()))
      @$el.backboneLink(@post)
      @editor()
      @

    editor: =>
      @editor = new TextEditorView()
      @$('.editor').append(@editor.render().el)

    submitData: (e) =>
      e.preventDefault()
      @post.set body: @$('.wysiwyg-editor').html()
      @post.save()

    handleError: (model, res) =>
      err = new ErrorView error: res.responseText, el: @el

    handleSuccess: =>
      @post.clear()

    leave: =>
      @post.off 'error'
      @post.off 'sync'
      @editor.leave()
      @remove()
