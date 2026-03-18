class HouseRoom < ApplicationRecord
  belongs_to :house

  has_many :tenants
  
  enum status: { vacant: "vacant", occupied: "occupied" }
end
