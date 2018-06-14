require 'paypal-sdk-rest'
include PayPal::SDK::REST
class PayoutJob < ApplicationJob
  queue_as :default

  def perform(reservation,status)
    if status == "COMPLETED"
      reservation.user.increment!(:balance,reservation.amount)
      Notif.create(event: "<a href='#{Rails.application.routes.url_helpers.reservation_url(reservation.slug)}'>Employer accepted your work for his job.</a>",user_id: reservation.user.id)
      Notif.create(event: "<a href='#{Rails.application.routes.url_helpers.reservation_url(reservation.slug)}'>Job posted by #{reservation.job.user.username} is now completed.</a>",user_id: User.admins.first.id)
      statement = Statement.create(user: reservation.user,email: reservation.user.email,amount: reservation.amount,status: "PENDING")
      @payout = Payout.new(
            {
              :sender_batch_header => {
                :sender_batch_id => SecureRandom.hex(8),
                :email_subject => 'You have a Payout!',
              },
              :items => [
                {
                  :recipient_type => 'EMAIL',
                  :amount => {
                    :value => reservation.amount
                    :currency => 'USD'
                  },
                  :note => 'Thanks for your patronage!',
                        sender_item_id: "#{statement.id}",
                        receiver: reservation.user.email
                }
              ]
            }
          )
          
          begin
            @payout_batch = @payout.create
            logger.info "Created Payout with [#{@payout_batch.batch_header.payout_batch_id}]"
          rescue ResourceNotFound => err
            logger.error @payout.error.inspect
          end
    end
    if status == "REJECTED"
      reservation.job.user.increment!(:balance,reservation.amount)
      reservation.job.blocked_users.create(user_id: reservation.user.id)
      reservation.job.update(status: "LIVE")
      Notif.create(event: "<a href='#{Rails.application.routes.url_helpers. reservation_url(reservation.slug)}'>Employer rejected your work for his job.</a>",user_id: reservation.user.id)
      statement = Statement.create(user: reservation.job.user,email: reservation.job.user.email,amount: reservation.amount,status: "PENDING")
      @payout = Payout.new(
            {
              :sender_batch_header => {
                :sender_batch_id => SecureRandom.hex(8),
                :email_subject => 'You have a Payout!',
              },
              :items => [
                {
                  :recipient_type => 'EMAIL',
                  :amount => {
                    :value => reservation.amount,
                    :currency => 'USD'
                  },
                  :note => 'Thanks for your patronage!',
                        sender_item_id: "#{statement.id}",
                        receiver: reservation.job.user.email
                }
              ]
            }
          )
          
          begin
            @payout_batch = @payout.create
            logger.info "Created Payout with [#{@payout_batch.batch_header.payout_batch_id}]"
          rescue ResourceNotFound => err
            logger.error @payout.error.inspect
          end
    end
  end
end
