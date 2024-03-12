class AddAvailableUntilToBoats < ActiveRecord::Migration[7.1]
  def change
    add_column :boats, :available_until, :date
  end
end
