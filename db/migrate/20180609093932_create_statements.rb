class CreateStatements < ActiveRecord::Migration[5.1]
  def change
    create_table :statements do |t|
      t.belongs_to :user, foreign_key: true
      t.string :email
      t.float :amount
      t.string :status
      t.string :slug
      t.timestamps
    end
    add_index :statements, :slug, unique: true
  end
end
