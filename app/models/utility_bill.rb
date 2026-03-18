class UtilityBill < ApplicationRecord
  belongs_to :monthly_bill

  before_save :calculate_amount

  def calculate_amount
    self.total_units = end_unit.to_f - start_unit.to_f
    self.amount = total_units * unit_rate
  end
end
