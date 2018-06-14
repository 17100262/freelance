$ ->
    $counter = $('#notification-counter')
    # alert($('#recepient').data("recepient"))
    unless @initializednoti
        App.chat = App.cable.subscriptions.create {
            channel: "NotificationsChannel"
            recepient: $('#recepient').data("recepient")
            },
            connected: ->
                # alert('connected'+$('#recepient').data("recepient"))
            disconnected: ->
            
            received: (data) ->
                $('#notificationList').prepend data['notification']
                toastr.success(data['push']);
                if data['counter']
                    App.chat.update_counter data['counter'];
                # if $('#messages').length < 1
            update_counter: (counter) ->
                val = parseInt $counter.text()
                val++
                $counter.text(val)
            @initializednoti = true
            
        