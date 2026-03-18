class CreateRents < ActiveRecord::Migration[7.2]
  def change
    create_table :rents do |t|
      t.references :tenant, null: false, foreign_key: true
      t.string :month
      t.decimal :rent_amount
      t.decimal :electricity_share
      t.decimal :total_amount
      t.decimal :paid_amount, default: 0
      t.decimal :due_amount
      t.string :status
      t.timestamps
    end
  end
end
