define [
  'backbone'
  'views/admin/post/search/item-view'
  'text!templates/admin/post/search/list-view.html'
], (Backbone, ItemView, Template) ->

  class ListView extends Backbone.View
    tagName: 'table'
    className: 'table table-striped table-bordered table-condensed'

    initialize: (options) ->
      @template = _.template(Template)

    render: =>
      @$el.html(@template)
      @addAll()
      @

    addAll: =>
      @collection.each(@addOne)

    addOne: (model) =>
      view = new ItemView model: model
      @$el.append(view.render().el)

    leave: =>
      @remove()
      @collection.off 'destroy'
