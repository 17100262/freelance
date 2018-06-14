class Job < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  has_attached_file :document
  validates_attachment :document,
    content_type: { content_type: ["text/plain","application/pdf",'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', "image/jpeg", "image/gif", "image/png", "image/jpg", "image/bmp""application/vnd.ms-excel","application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"] }
  
  belongs_to :user
  belongs_to :category
  belongs_to :subcategory
  has_many :blocked_users,dependent: :destroy
  has_many :blocked_people, :through => :blocked_users, :source => :user
  
  has_many :attachments,dependent: :destroy
  
  has_many :reservations,dependent: :destroy
  
  has_many :workers, :through => :reservations,source: :job
  after_create_commit :add_blocked
  

  # after_update :notify_reserved, :if => proc{ |obj| obj.status_changed? && obj.status == 'RESERVED' }
  
  def add_blocked
    self.blocked_users.create(user_id: self.user.id)
  end
  
  # def notify_live
  #   Notif.create(event: "<a href='#{Rails.application.routes.url_helpers.job_url(self.slug)}'>Your Payment was successfull and your job is now live.</a>",user_id: self.user.id)
  #   Notif.create(event: "<a href='#{Rails.application.routes.url_helpers.job_url(self.slug)}'>Job posted by #{self.user.name} is now Live.</a>",user_id: self.user.id)
  # end
  
  def purchase(token,ip)
    response = EXPRESS_GATEWAY.purchase(self.amount_in_cents, express_purchase_options(token,ip))
    response
  end
  def amount_in_cents
    self.amount * 100
  end
  def express_purchase_options(token,ip)
    { 
      :ip => ip,
      :token => token,
      :payer_id => EXPRESS_GATEWAY.details_for(token).payer_id
    }
  end
  
  # define_index do
  #   indexes title
  #   indexes description
  # end
  
end
