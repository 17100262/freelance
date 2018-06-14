class Statement < ApplicationRecord
  belongs_to :user
  extend FriendlyId
  friendly_id :generated_slug, use: :slugged
  
  
  def generated_slug
    random_slug = ('a'..'z').to_a.shuffle[0,16].join
    while Statement.exists?(slug: random_slug)
      random_slug = ('a'..'z').to_a.shuffle[0,16].join
    end
    return random_slug
  end
end
