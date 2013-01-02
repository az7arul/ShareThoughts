$(->
  if $('#send_message').length > 0
    $('#send_message').bind 'keypress', (e) ->
      if e.shiftKey == false && e.keyCode == 13
        $(@).parent().submit()
)
