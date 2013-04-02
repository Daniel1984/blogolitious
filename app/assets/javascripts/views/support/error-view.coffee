define [
  'backbone'
], (Backbone) ->

  class ErrorView extends Backbone.View
    
    events:
      'keydown input': 'removeError'
      'change select': 'removeError'

    initialize: (options) ->
      @el = options.el
      @error = JSON.parse(options.error)
      @render()

    render: =>
      if @error.errors
        for key, val of @error.errors
          @renderError(key, val.type)
      else
        for key, val of @error
          @renderError(key, val)


    renderError: (field, msg) =>
      @$(".base").html("<div class='alert alert-error'>#{msg}</div>")
      @$(".#{field}").closest('div[class^="control-group"]').addClass('error')
      @$(".#{field}").closest('div[class^="controls"]').find('.help-inline').remove()
      @$(".#{field}").closest('div[class^="controls"]').append("<span class='help-inline'>#{msg}</span>")
      @$('.btn').addClass('disabled')

    removeError: (e) =>
      @$(e.currentTarget).closest('div[class^="control-group"]').removeClass('error')
      @$(e.currentTarget).closest('div[class^="controls"]').find('.help-inline').remove()
      @$('.btn').removeClass('disabled')
