define [
  'backbone'
  'views/support/wysiwyg'
  'text!templates/admin/post/edit/show-view.html'
  'views/support/error-view'
], (Backbone, TextEditorView, Template, ErrorView) ->
  class EditPostView extends Backbone.View
    tagName: 'form'
    className: 'form-vertical'
    
    initialize: (options) ->
      @template = _.template(Template)
      @post = options.post
      @post.on 'update:modal:post', @submitData
      @post.on 'error', @handleError
      @post.on 'sync', @handleSuccess
      
    render: =>
      console.log 'rendering post edit', @post.toJSON()
      @$el.html(@template(@post.toJSON()))
      @$el.backboneLink(@post)
      @editor()
      @

    editor: =>
      @editor = new TextEditorView()
      @$('.editor').append(@editor.render().el)
      @$('.wysiwyg-editor').html(@post.get 'body')

    submitData: =>
      @post.set body: @$('.wysiwyg-editor').html()
      @post.save()

    handleError: (model, err) =>
      error = new ErrorView el: @el, error: err.responseText

    handleSuccess: =>
      console.log 'success'

    leave: =>
      @editor.leave()
      @post.off 'update:modal:post'
      @post.off 'error'
      @post.off 'sync'
      @remove()
