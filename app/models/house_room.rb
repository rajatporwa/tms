class HouseRoom < ApplicationRecord
  belongs_to :house

  has_many :tenants
  has_many :monthly_bills, dependent: :destroy

  enum status: { vacant: "vacant", occupied: "occupied" }
end
