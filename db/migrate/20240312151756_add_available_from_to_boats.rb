class AddAvailableFromToBoats < ActiveRecord::Migration[7.1]
  def change
    add_column :boats, :available_from, :date
  end
end
