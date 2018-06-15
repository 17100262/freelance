class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :jobs, :dependent => :destroy
end