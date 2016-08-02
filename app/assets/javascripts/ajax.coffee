# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
init = ->
  $(document).ajaxStart ->
    $('#progress').html '通信中...'
    .ajaxComplete ->
      $('#progress').html ''
