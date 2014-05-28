# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  displayFormErrors()
  scrollToLastToolTip()

@displayFormErrors = () ->
  $('.form-control').each ->
    if $(@).data('error').length > 0
      displayToolTip $(@), $(@).data('error').join(', ')

displayToolTip = (targetElement, message) ->
  tooltip = $("<span class=\"tooltip error\">#{message}</span>")
  targetElement.after tooltip
  tooltip.css 'right', -(tooltip.outerWidth() + 10) + 'px'

scrollToLastToolTip = () ->
  $('html, body').animate({scrollTop: $('.error').last().offset().top}, 100);
