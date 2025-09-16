class CreateHouseRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :house_rooms do |t|
      t.references :house, null: false, foreign_key: true
      t.integer :room_number
      t.decimal :rent
      t.string :status
      t.string :month_of_rent
      t.integer :previous_month_electricity_reading
      t.integer :current_month_electricity_reading
      t.decimal :electricity_bill
      t.decimal :total_amount
      t.boolean :paid_status

      t.timestamps
    end
  end
end
