class ChangeColumnNameInBoats < ActiveRecord::Migration[7.1]
  def change
    rename_column :boats, :users_id, :user_id
    
  end
end
