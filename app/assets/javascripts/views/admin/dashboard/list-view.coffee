define [
  'backbone'
  'views/admin/dashboard/item-view'
], (Backbone, ItemView) ->

  class ListView extends Backbone.View
    tagName: 'ul'
    className: 'nav nav-tabs nav-stacked affix'

    initialize: (options) ->
      @collection.on 'reset', @render

    render: =>
      @$el.html()
      @addAll()
      @

    addAll: =>
      @collection.each(@addOne)

    addOne: (model) =>
      @itemView = new ItemView model: model
      @$el.append(@itemView.render().el)

    leave: =>
      @remove()
