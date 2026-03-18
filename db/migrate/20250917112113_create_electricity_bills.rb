class CreateElectricityBills < ActiveRecord::Migration[7.2]
  def change
    create_table :electricity_bills do |t|
      t.references :house_room, null: false, foreign_key: true
      t.date :month
      t.integer :units, default: 0
      t.integer :per_unit, default: 0
      t.decimal :amount, default: 0
      t.integer :previous_units, default: 0
      t.integer :current_units, default: 0
      t.string :status

      t.timestamps
    end
  end
end
