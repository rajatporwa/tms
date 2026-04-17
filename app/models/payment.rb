class Payment < ApplicationRecord
  belongs_to :tenant
  belongs_to :rent, optional: true
  belongs_to :monthly_bill, optional: true

  validates :amount, :payment_date, :payment_mode, presence: true

  after_save :update_associated_statuses
  after_destroy :update_associated_statuses

  PAYMENT_MODES = %w[cash UPI bank]

  def update_associated_statuses
    rent.update_paid_and_due_amounts! if rent.present?
    
    if monthly_bill.present?
      monthly_bill.update(paid_amount: monthly_bill.payments.sum(:amount))
      monthly_bill.calculate_totals
      monthly_bill.save
    end
  end

  def upi_qr_code_url
    return nil unless payment_mode&.downcase == 'upi'
    upi_id = ENV['TMS_UPI_ID'] || 'your-upi-id@okicici'
    payee_name = ENV['TMS_PAYEE_NAME'] || 'TMS Owner'
    amt = amount.to_f
    note = "TMS Rent Payment"
    upi_link = "upi://pay?pa=#{upi_id}&pn=#{payee_name}&am=#{amt}&cu=INR&tn=#{note}"
    "https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=#{CGI.escape(upi_link)}"
  end
end
