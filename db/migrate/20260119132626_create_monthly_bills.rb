class CreateMonthlyBills < ActiveRecord::Migration[7.2]
  def change
    create_table :monthly_bills do |t|
      t.references :house, null: false, foreign_key: true
      t.references :house_room, null: false, foreign_key: true
      t.references :tenant, null: false, foreign_key: true
      t.integer :month
      t.integer :year
      t.decimal :rent_amount
      t.decimal :utility_amount
      t.decimal :maintenance_amount
      t.decimal :total_amount
      t.decimal :paid_amount
      t.string :status
      t.date :due_date
      t.date :date

      t.timestamps
    end
  end
end
