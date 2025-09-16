class CreateHouses < ActiveRecord::Migration[7.2]
  def change
    create_table :houses do |t|
      t.string :house_name
      t.string :address
      t.string :owner_name
      t.integer :owner_id
      t.integer :no_of_rooms

      t.timestamps
    end
  end
end
