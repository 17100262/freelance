class CreateBlockedUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :blocked_users do |t|
      t.belongs_to :job, foreign_key: true
      t.belongs_to :user, foreign_key: true
    end
  end
end
