class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :job
  extend FriendlyId
  friendly_id :generated_slug, use: :slugged
  
  after_create_commit :notify
  
  def generated_slug
    random_slug = ('a'..'z').to_a.shuffle[0,16].join
    while Reservation.exists?(slug: random_slug)
      random_slug = ('a'..'z').to_a.shuffle[0,16].join
    end
    return random_slug
  end
  
  def notify
    worker = self.user
    employer = self.job.user
    Notif.create(event: "<a href='#{Rails.application.routes.url_helpers.reservation_url(self.slug)}'>#{worker.username} reserved your job.</a>", user_id: employer.id)
    Notif.create(event: "<a href='#{Rails.application.routes.url_helpers.reservation_url(self.slug)}'>#{worker.username} reserved job of #{employer.username}.</a>", user_id: User.admins.first.id)
  end
  
  def notify_delivered
    Notif.create(event: "<a href='#{Rails.application.routes.url_helpers.reservation_url(self.slug)}'>#{self.user.username} delivered work for reservation of your job.</a>", user_id: self.job.user.id)
  end
  
  def purchase(token,ip)
    response = EXPRESS_GATEWAY.purchase(self.job.amount_in_cents, express_purchase_options(token,ip))
    response
  end
  def express_purchase_options(token,ip)
    { 
      :ip => ip,
      :token => token,
      :payer_id => EXPRESS_GATEWAY.details_for(token).payer_id
    }
  end
  
  
end
