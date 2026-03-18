class Rent < ApplicationRecord
  belongs_to :tenant
  has_many :payments, dependent: :destroy

  validates :month, :rent_amount, :total_amount, presence: true

  enum status: { paid: "paid", partial: "partial", unpaid: "unpaid" }

  before_save :auto_calculate_amounts

  def update_paid_and_due_amounts!
    self.paid_amount = payments.sum(:amount)
    self.due_amount = total_amount.to_f - paid_amount.to_f
    self.status =
      if paid_amount.to_f == 0
        "unpaid"
      elsif paid_amount.to_f < total_amount
        "partial"
      else
        "paid"
      end
    save(validate: false)
  end

  def auto_calculate_amounts
    self.electricity_share ||= calculate_electricity_share
    self.total_amount = rent_amount.to_f + electricity_share.to_f
    self.due_amount = total_amount.to_f - paid_amount.to_f
    self.status =
      if paid_amount.to_f == 0
        "unpaid"
      elsif paid_amount.to_f < total_amount
        "partial"
      else
        "paid"
      end
  end

  def calculate_electricity_share
    # Example: fetch latest bill for tenant's room and divide by partners
    room = tenant.house_room
    bill = room.monthly_bills.where(month: month).first
    partners = tenant.tenant_partners.count + 1
    bill&.utility_amount.to_f / partners rescue 0
  end
end
