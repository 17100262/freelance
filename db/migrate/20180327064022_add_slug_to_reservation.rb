class AddSlugToReservation < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :slug, :string
    add_index :reservations, :slug
  end
end
