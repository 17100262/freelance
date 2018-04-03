class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.string :status, default: "PENDING"
      t.belongs_to :user, foreign_key: true
      t.belongs_to :job, foreign_key: true
      t.datetime :ending_time

      t.timestamps
    end
  end
end
