class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    if params[:recepient].present?
      stream_from "notify_#{params[:recepient]}_channel"
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
