define [
  'backbone'
  'text!templates/admin/navbar/item-view.html'
], (Backbone, Template) ->

  class NavItemView extends Backbone.View
    tagName: 'li'

    events:
      'click': 'displayActiveView'

    initialize: (options) ->
      @template = _.template(Template, @model.toJSON())
      @model.on 'change:viewActive', @updateActiveView

    render: =>
      @$el.html(@template)
      @updateActiveView()
      @

    updateActiveView: =>
      if @model.get 'viewActive'
        @$el.removeClass 'inactive'
        @$el.addClass 'active'
      else
        @$el.removeClass 'active'
        @$el.addClass 'inactive'

    displayActiveView: (e) =>
      e.preventDefault()
      @model.activateView()
      @model.collection.viewChanged(@model)

    leave: =>
      @model.off 'change:viewActive'
      @remove()
