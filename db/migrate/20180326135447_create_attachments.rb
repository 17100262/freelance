class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.attachment :file
      t.belongs_to :job
    end
  end
end
