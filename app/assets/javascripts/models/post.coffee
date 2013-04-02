define [
  'backbone'
], (Backbone) ->
  class PostModel extends Backbone.Model
    idAttribute: '_id'
    urlRoot: '/posts'
