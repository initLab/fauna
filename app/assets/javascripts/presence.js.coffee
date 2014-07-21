$(document).on "page:change", ->
  $('#presence .avatar img').on 'load', ->
    $(this).parent().fadeIn()
  .each ->
    if $(this).complete
      $(this).trigger 'load'
