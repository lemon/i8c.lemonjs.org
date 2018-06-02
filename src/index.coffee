
# dependencies
require './App'

# page template
module.exports = ->
  doctype 5
  html lang: 'en', ->
    head ->
      title 'icons8 (cotton)'
    body ->
      site.App()
      script {
        type: 'text/javascript'
        src: 'https://cdn.jsdelivr.net/npm/lozad/dist/lozad.min.js'
      }
