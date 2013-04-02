define [
  'text!templates/support/modal.html'
], (Template) ->

  class ModalView extends Backbone.View
    className: 'modal hide fade'
    events:
      'click #submit-modal-data': 'submitData'

    initialize: (options) ->
      @model.on 'sync', @removeView
      @action = options.action
      @view = options.body
      @title = options.title
      @template = _.template(Template, title: @title)
      @render()

    render: =>
      @$el.html(@template)
      if @view?.render
        @$('.modal-body').append(@view.render().el)
      else
        @$('.modal-body').append(@view)
      $(@el).modal('show')
      $(@el).on 'hidden', @leave
      @

    submitData: (e) =>
      e.preventDefault()
      switch @action
        when 'signin' then @model.signIn()
        when 'edit-post' then @model.trigger 'update:modal:post'
        when 'delete' then @model.destroy()
        else @model.save()

    removeView: =>
      $(@el).modal('hide')
    
    leave: =>
      @model.off 'sync'
      @remove()
