define [
  'backbone'
], (Backbone) ->
  class DashboardItem extends Backbone.Model
    activateView: () ->
      if !@get 'viewActive'
        @set 'viewActive': true
        @trigger 'active:view:changed', @
