requirejs.config(
  paths:
    text: 'lib/require/text'
    is: 'lib/require/is'
    'is-api': 'lib/require/is-api'
    jquery: 'lib/jquery'
    underscore: 'lib/underscore'
    backbone: 'lib/backbone'
    'backbone-datalink': 'lib/backbone/backbone-datalink'
    bootstrap: 'lib/bootstrap'
    mobile: 'helper/device-detection'
  shim:
    underscore:
      exports: '_'
    backbone:
      deps: ['underscore', 'jquery', 'backbone-datalink']
      exports: 'Backbone'
)
requirejs ['app-admin'], (App) ->
  App.init()
