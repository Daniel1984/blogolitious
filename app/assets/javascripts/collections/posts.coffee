define [
  'backbone'
  'models/post'
], (Backbone, Post) ->

  class Posts extends Backbone.Collection
    model: Post
    url: '/posts'
