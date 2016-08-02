init = ->
  $(document).ajaxStart ->
    $('#progress').html '通信中...'
    .ajaxComplete ->
      $('#progress').html ''
