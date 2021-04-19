class Gase < ApplicationRecord
  validates :name, presence: true
  validates :amount, presence: true
  validates :price, presence: true
  validates :is_active, presence: true
  has_many :gas_requests
  has_many :order_gases
end
