class CreateHouseRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :house_rooms do |t|
      t.references :house, null: false, foreign_key: true
      t.integer :room_number
      t.decimal :rent
      t.string :status, default: "vacant", null: false

      t.timestamps
    end
  end
end
