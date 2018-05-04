class Job < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  belongs_to :user
  belongs_to :category
  has_many :blocked_users,dependent: :destroy
  has_many :blocked_people, :through => :blocked_users, :source => :user
  
  has_many :attachments,dependent: :destroy
  
  has_many :reservations,dependent: :destroy
  
  has_many :workers, :through => :reservations,source: :job
  
  
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
  
end
