define [
  'backbone'
  'text!templates/admin/video/show-view.html'
], (Backbone, Template) ->

  class VideoView extends Backbone.View
    className: 'video-view'

    initialize: (options) ->
      @template = _.template(Template)

    render: =>
      @$el.html(@template)
      @

    leave: =>
      @remove()
