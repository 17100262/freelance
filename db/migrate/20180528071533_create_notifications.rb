class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :event
      t.belongs_to :user, foreign_key: true
      t.boolean :read

      t.timestamps
    end
  end
end
