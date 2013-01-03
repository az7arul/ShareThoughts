$(->
  if $('.topic-list').length > 0
    $('#dashboard_topic').change ->
      $.ajax '/messages/get_messages_by_topic',
        type: 'POST'
        dataType: 'script'
        data: { topic_id: $(this).val()}

)
