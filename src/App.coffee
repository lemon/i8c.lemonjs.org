
# stylesheets
require './css/App.styl'

# dependencies
require 'lemonjs-lui/Footer'
require 'lemonjs-lui/Grid'
require 'lemonjs-lui/Header'
require 'lemonjs-lui/Input'

# load icon names
icons = require 'lemonjs-i8c/map.json'

# component
module.exports = lemon.Component {
  package: 'site'
  name: 'App'
  id: 'app'

  data: {
    icons: icons
    query: ''
  }

  lifecycle: {
    mounted: ->
      @loadImages()
  }

  methods: {
    loadImages: ->
      icons = @el.querySelectorAll 'img.icon'
      observer = lozad(icons)
      observer.observe()

    onSearch: (e) ->
      clearTimeout @timeout_id if @timeout_id
      @timeout_id = setTimeout ( =>
        @query = @$search.value
        @loadImages()
      ), 300
  }

  template: (data) ->

    lui.Header {
      logo: 'lemon + icons8 (cotton)'
      nav: [
        {href: 'https://github.com/lemon/i8c.lemonjs.org', text: 'website'}
        {href: 'https://github.com/lemon/lemonjs-i8c', text: 'library'}
      ]
    }

    div '.search', ->
      lui.Input {
        ref: '$search'
        label: 'search for an icon'
        onKeyUp: 'onSearch'
      }

    div '.icons', ->
      div _on: 'query', _template: (query, data) ->
        items = ({
          icon: ->
            img '.icon', 'data-src': "/img/#{this.code}.png"
          code: code
          name: name
        } for code, name of data.icons when name.toLowerCase().indexOf(query) > -1)
        if items.length is 0
          div '.no-match', ->
            'No icons matching your search'
        else
          lui.Grid {
            items: items
          }

    lui.Footer {}, ->
      div ->
        'Released under the MIT License'
      div ->
        '© Copyright 2018 Shenzhen239'

    script type: 'text/javascript', src: '/lazy-load-images.js'
}
