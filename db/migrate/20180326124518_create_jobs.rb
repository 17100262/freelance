class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :status,default: "PENDING"
      t.string :title
      t.text :description
      t.text :deliverables
      t.integer :duration
      t.string :language
      t.float :amount
      t.boolean :online
      t.text :address
      t.attachment :document
      t.belongs_to :user, foreign_key: true
      t.belongs_to :category, foreign_key: true
      t.belongs_to :subcategory, foreign_key: true
      t.timestamps
    end
  end
end
