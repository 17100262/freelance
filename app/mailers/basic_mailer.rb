class BasicMailer < ApplicationMailer
    def send_email(notif)
        @recepient = notif.user
        @notif = notif
        if Rails.env.production?
            mail(to: @recepient.email, subject: 'New Notification on Scholarden')
        end
    end
end
