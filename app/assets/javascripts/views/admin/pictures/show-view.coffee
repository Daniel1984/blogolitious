define [
  'backbone'
  'text!templates/admin/pictures/show-view.html'
], (Backbone, Template) ->

  class PicView extends Backbone.View
    className: 'pic-view'

    initialize: (options) ->
      @template = _.template(Template)

    render: =>
      @$el.html(@template)
      @
      
    leave: =>
      @remove()
