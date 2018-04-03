class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :job
  extend FriendlyId
  friendly_id :generated_slug, use: :slugged
  
  after_create_commit :update_job
  
  
  def generated_slug
    random_slug = ('a'..'z').to_a.shuffle[0,16].join
    while Reservation.exists?(slug: random_slug)
      random_slug = ('a'..'z').to_a.shuffle[0,16].join
    end
    return random_slug
  end
  
  def update_job
    self.job.update(status: "RESERVED")
  end
  
  
  
end
