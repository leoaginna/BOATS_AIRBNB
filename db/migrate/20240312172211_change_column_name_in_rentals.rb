class ChangeColumnNameInRentals < ActiveRecord::Migration[7.1]
  def change
    rename_column :rentals, :boats_id, :boat_id
    rename_column :rentals, :users_id, :user_id
  end
end
