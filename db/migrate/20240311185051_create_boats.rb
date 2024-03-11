class CreateBoats < ActiveRecord::Migration[7.1]
  def change
    create_table :boats do |t|
      t.string :name
      t.text :description
      t.float :price
      t.string :address
      t.boolean :available

      t.timestamps
    end
  end
end
