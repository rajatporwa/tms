class UpdatePaymentsForRentAndTenant < ActiveRecord::Migration[7.2]
  def change
    change_table :payments do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :rent, null: false, foreign_key: true
      t.date :payment_date
      t.string :transaction_id
      t.string :note
      t.rename :paid_on, :old_paid_on if column_exists?(:payments, :paid_on)
      t.remove :monthly_bill_id if column_exists?(:payments, :monthly_bill_id)
    end
  end
end