// Generated by CoffeeScript 1.10.0
(function() {
  $(function() {
    var $counter;
    $counter = $('#notification-counter');
    if (!this.initializednoti) {
      return App.chat = App.cable.subscriptions.create({
        channel: "NotificationsChannel",
        recepient: $('#recepient').data("recepient")
      }, {
        connected: function() {},
        disconnected: function() {},
        received: function(data) {
          $('#notificationList').prepend(data['notification']);
          toastr.success(data['push']);
          if (data['counter']) {
            return App.chat.update_counter(data['counter']);
          }
        },
        update_counter: function(counter) {
          var val;
          val = parseInt($counter.text());
          val++;
          return $counter.text(val);
        }
      }, this.initializednoti = true);
    }
  });

}).call(this);
