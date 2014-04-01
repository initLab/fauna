# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ = jQuery

$(document).on "page:change", ->
    $('.form-control').each ->
        data_error = $(@).data('error')

        if data_error.length
            $(@).parent().append '<div class="tooltip"></div>'

            tooltip = $(@).siblings('.tooltip')
            tooltip.text(data_error)
                   .css('right', -(tooltip.outerWidth() + 10) + 'px')


