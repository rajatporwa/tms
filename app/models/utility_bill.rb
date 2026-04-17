class UtilityBill < ApplicationRecord
  belongs_to :monthly_bill

  before_save :calculate_amount
  after_save :update_monthly_bill_totals
  after_destroy :update_monthly_bill_totals

  def calculate_amount
    self.total_units = end_unit.to_f - start_unit.to_f
    self.amount = total_units * unit_rate
  end

  private

  def update_monthly_bill_totals
    monthly_bill.save! # This will trigger the `calculate_totals` before_save callback on MonthlyBill
  end
end
