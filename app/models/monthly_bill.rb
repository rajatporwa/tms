class MonthlyBill < ApplicationRecord
  belongs_to :house
  belongs_to :house_room
  belongs_to :tenant

  has_many :utility_bills, dependent: :destroy
  has_many :payments, dependent: :destroy

  accepts_nested_attributes_for :utility_bills, allow_destroy: true, reject_if: proc { |attr| attr['start_unit'].blank? && attr['end_unit'].blank? }

  before_save :calculate_totals

  STATUSES = %i[pending partial paid]

  validates :month, :year, presence: true

  def calculate_totals
    self.utility_amount = utility_bills.sum(:amount)
    self.total_amount = rent_amount.to_f + utility_amount.to_f + maintenance_amount.to_f
    self.status =
      if paid_amount.to_f == 0
        "pending"
      elsif paid_amount.to_f < total_amount.to_f
        "partial"
      else
        "paid"
      end
  end

  def display_name
    "#{Date::MONTHNAMES[month]} #{year} (Due: ₹#{total_amount.to_f - paid_amount.to_f})"
  end
end
