$(document).on "page:change", ->
  $('.edit_gravatar').mouseenter ->
    $(this).find('.overlay').show()
  $('.edit_gravatar .overlay').mouseleave ->
    $(this).fadeOut()
