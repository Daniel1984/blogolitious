define [
  'backbone'
], (Backbone) ->
  class NavItem extends Backbone.Model
    activateView: () ->
      if !@get 'viewActive'
        @set 'viewActive': true
        @trigger 'active:view:changed', @
