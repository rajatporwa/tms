class CreateUtilityBills < ActiveRecord::Migration[7.2]
  def change
    create_table :utility_bills do |t|
      t.references :monthly_bill, null: false, foreign_key: true
      t.string :utility_type
      t.decimal :start_unit
      t.decimal :end_unit
      t.decimal :unit_rate
      t.decimal :total_units
      t.decimal :amount

      t.timestamps
    end
  end
end
