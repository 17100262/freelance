class CreateVariables < ActiveRecord::Migration[5.1]
  def change
    create_table :variables do |t|
      t.string :name
      t.integer :value
      t.string :description
      t.timestamps
    end
  end
end
