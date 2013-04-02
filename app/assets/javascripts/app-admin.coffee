define [
  'jquery'
  'backbone'
  'views/admin/site/show-view'
  'models/user'
  'backbone-datalink'
  'bootstrap' 
], ($, Backbone, Site, User, DataLink, Bootstrap) ->
  init: ->
    $( ->
      user = new User window.blg_user
      siteView = new Site user: user
      $('body').append(siteView.render().el)
      @
    )
