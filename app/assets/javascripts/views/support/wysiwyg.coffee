define [
  'backbone'
  'text!templates/support/wysiwyg.html'
], (Backbone, Template) ->

  class WYSIWYG extends Backbone.View

    events:
      'click .wysiwyg-bold': 'makeBold'
      'click .wysiwyg-italic': 'makeItalic'
      'click .wysiwyg-underline': 'makeUnderline'
      'click .wysiwyg-hr': 'makeHorizontalLine'
      'click .wysiwyg-left': 'alignLeft'
      'click .wysiwyg-center': 'alignCenter'
      'click .wysiwyg-right': 'alignRight'
      'click .wysiwyg-ul': 'insertUnorderedList'
      'click .wysiwyg-ol': 'insertOrderedList'
      'click .wysiwyg-indentL': 'leftIndent'
      'click .wysiwyg-indentR': 'rightIndent'
      'click .wysiwyg-link': 'insertLink'
      'click .wysiwyg-color': 'changeColor'
      'click .wysiwyg-bgColor': 'changeBgColor'
      'click .wysiwyg-size': 'changeSize'
    
    initialize: (options) ->
      super(options)
      @template = _.template(Template)
      
    render: =>
      @$el.html(@template)
      @
    
    makeBold: (e) =>
      e.preventDefault()
      document.execCommand('bold',null,false)

    makeItalic: (e) =>
      e.preventDefault()
      document.execCommand('italic',null,false)

    makeUnderline: (e) =>
      e.preventDefault()
      document.execCommand('underline',null,false)

    makeHorizontalLine: (e) =>
      e.preventDefault()
      document.execCommand('inserthorizontalrule',null,false)

    alignLeft: (e) =>
      e.preventDefault()
      document.execCommand('justifyleft',null,false)

    alignCenter: (e) =>
      e.preventDefault()
      document.execCommand('justifycenter',null,false)

    alignRight: (e) =>
      e.preventDefault()
      document.execCommand('justifyright',null,false)

    insertUnorderedList: (e) =>
      e.preventDefault()
      document.execCommand('insertunorderedlist',null,false)

    insertOrderedList: (e) =>
      e.preventDefault()
      document.execCommand('insertorderedlist',null,false)

    leftIndent: (e) =>
      e.preventDefault()
      document.execCommand('indent',null,false)

    rightIndent: (e) =>
      e.preventDefault()
      document.execCommand('outdent',null,false)

    insertLink: (e) =>
      e.preventDefault()
      link = prompt('Please enter your link:', 'http://')
      document.execCommand('CreateLink',null,link)

    changeColor: (e) =>
      e.preventDefault()
      color = prompt('Enter name or hexadecimal value of color:','')
      document.execCommand('forecolor',null,color)

    changeBgColor: (e) =>
      e.preventDefault()
      bgColor = prompt('Enter name or hexadecimal value of color:','')
      document.execCommand('backcolor',null,bgColor)

    changeSize: (e) =>
      e.preventDefault()
      fSize = prompt('Enter the font size in pixels between 1 and 7','')
      document.execCommand('fontsize',null,fSize)

    leave: =>
      @remove()
