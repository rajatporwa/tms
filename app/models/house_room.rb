class HouseRoom < ApplicationRecord
  belongs_to :house
  
  enum status: { vacant: 0, occupied: 1 }
  enum paid_status: { paid: 1, unpaid: 1}
end
