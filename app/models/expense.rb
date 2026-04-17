class Expense < ApplicationRecord
  belongs_to :house
  
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :expense_type, presence: true
  validates :expense_date, presence: true
end
