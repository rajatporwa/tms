class Payment < ApplicationRecord
  belongs_to :tenant
  belongs_to :rent

  validates :amount, :payment_date, :payment_mode, presence: true

  after_save :update_rent_status

  PAYMENT_MODES = %w[cash UPI bank]

  def update_rent_status
    rent.update_paid_and_due_amounts!
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
