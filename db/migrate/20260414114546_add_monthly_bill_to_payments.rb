class AddMonthlyBillToPayments < ActiveRecord::Migration[7.2]
  def change
    add_reference :payments, :monthly_bill, null: true, foreign_key: true
    change_column_null :payments, :rent_id, true
  end
end
