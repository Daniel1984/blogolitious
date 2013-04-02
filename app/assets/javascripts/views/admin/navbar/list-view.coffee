define [
  'backbone'
  'views/admin/navbar/item-view'
], (Backbone, NavItemView) ->

  class NavListView extends Backbone.View
    className: 'nav'
    tagname: 'ul'

    initialize: (options) ->
      @collection.on "reset", @render

    render: =>
      @$el.html()
      @addAll()
      @

    addAll: =>
      @collection.each(@addOne)

    addOne: (model) =>
      @view = new NavItemView model: model
      @$el.append(@view.render().el)
