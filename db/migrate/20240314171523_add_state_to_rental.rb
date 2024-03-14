class AddStateToRental < ActiveRecord::Migration[7.1]
  def change
    add_column :rentals, :state, :string
  end
end
