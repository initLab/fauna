# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ = jQuery

$(document).on "page:change", ->

    $('.form-control').each ->
        data_error = $(@).data('error')

        tooltip = $(@).siblings('.tooltip')
        tooltip.text(data_error)
            .css('right', -(tooltip.outerWidth() + 10) + 'px')


        validateInput(data_error, tooltip)
        $(@).keypress ->
            validateInput(data_error, tooltip)
        

validateInput = (error, tooltip) ->
    if error.length
       tooltip.addClass('error')
    else
       tooltip.attr('class', 'tooltip')


