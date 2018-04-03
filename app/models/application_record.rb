class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
    def self.dorder
        self.order("created_at ASC")
    end
end
