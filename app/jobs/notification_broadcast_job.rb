class NotificationBroadcastJob < ApplicationJob
  queue_as :default
  
  def perform(counter,notif)
    ActionCable.server.broadcast "notify_User_#{notif.user_id}_channel",  counter: render_counter(counter) , notification: render_notification(notif),push: notif.event
  end
  
  private
  
  def render_counter(counter)
    ApplicationController.renderer.render(partial: 'notifications/counter', locals: { counter: counter })
  end
  
  def render_notification(noti)
    ApplicationController.renderer.render(partial: 'notifications/notification', locals: { notification: noti })
  end
end
