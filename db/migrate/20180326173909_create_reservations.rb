class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.string :status, default: "PENDING"
      t.belongs_to :user, foreign_key: true
      t.belongs_to :job, foreign_key: true
      t.datetime :ending_time
      t.float :amount
      t.string :review
      t.integer :rating
      t.text :revision_description
      t.text :rejection_description
      t.text :pause_reason
      t.datetime :paused_at
      t.timestamps
    end
  end
end
