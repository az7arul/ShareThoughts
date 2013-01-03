$(->
  if $('#send_message').length > 0
    $('#send_message').bind 'keypress', (e) ->
      if e.shiftKey == false && e.keyCode == 13
        $(@).parent().submit()
  if $('.topic').length > 0
    $('.change-topic').click ->
      $.ajax '/topics/change_topic',
        type: 'POST'
        dataType: 'script'
        data: { group_id: $('.topic').attr('id') , topic: $('.topic-text').val()}
)
