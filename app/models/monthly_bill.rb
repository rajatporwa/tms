class MonthlyBill < ApplicationRecord
  belongs_to :house
  belongs_to :house_room
  belongs_to :tenant

  has_many :utility_bills, dependent: :destroy
  has_many :payments, dependent: :destroy

  before_save :calculate_totals

  STATUSES = %i[pending partial paid]

  validates :month, :year, presence: true

  def calculate_totals
    self.utility_amount = utility_bills.sum(:amount)
    self.paid_amount ||= payments.sum(:amount)
    self.total_amount = rent.amount.to_f + utility_amount.to_f + maintanance_amount.to_f
    self.status = 
      if paid_amount.to_f == 0
        "pending"
      elsif paid_amount.to_f < total_amount
        "partial"
      else
        "paid"
      end    
  end
end
