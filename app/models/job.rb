class Job < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  belongs_to :user
  has_many :blocked_users,dependent: :destroy
  has_many :blocked_people, :through => :blocked_users, :source => :user
  
  has_many :attachments,dependent: :destroy
  
  has_many :reservations,dependent: :destroy
  
  has_many :workers, :through => :reservations,source: :job
  
  
  def paypal_url(return_path)
    values = {
        business: "merchant@gotealeaf.com",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: id,
        amount: self.amount,
        item_name: self.title,
        item_number: self.slug,
        quantity: '1'
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end
  
end
