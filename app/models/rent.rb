require 'cgi'

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
    partners = (tenant.tenant_partners.count + 1).to_f
    # Look for a monthly bill matching this rent's month string (e.g. "June 2026")
    # by checking the most recent bill for this tenant's room
    bill = tenant.house_room.monthly_bills.order(created_at: :desc).first
    return 0.0 if bill.nil? || bill.utility_amount.to_f.zero?
    (bill.utility_amount.to_f / partners).round(2)
  rescue
    0.0
  end

  # ─── WhatsApp Message Generation ───────────────────────────────────────────
  def whatsapp_message
    name = tenant.full_name
    <<~MSG
      Hello #{name},

      *Monthly Rent Statement*
      Month/Year: #{month}
      Tenant Name: #{name}
      Rent: Rs.#{rent_amount}
      Electricity Bill: Rs.#{electricity_share}
      Due Amount: Rs.#{due_amount}
      Total Payable: Rs.#{total_amount}
      Status: #{status.upcase}

      Please pay the due amount at the earliest.
      Thank you!
    MSG
  end

  def whatsapp_url
    phone = tenant.mobile.to_s.gsub(/\D/, '')
    # Prepend country code 91 for India if not already present
    phone = "91#{phone}" unless phone.start_with?("91")
    "https://wa.me/#{phone}?text=#{CGI.escape(whatsapp_message)}"
  end
end
