class Notif < ApplicationRecord
  belongs_to :user
  after_create_commit :notify
  
  private
    def notify
      NotificationBroadcastJob.perform_later(Notif.count,self)
      BasicMailer.send_email(self).deliver_later  
    end
end
