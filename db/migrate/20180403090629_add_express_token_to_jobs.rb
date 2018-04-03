class AddExpressTokenToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :express_token, :string
    add_column :jobs, :express_payer_id, :string
  end
end
