class OrderItem < ApplicationRecord
  belongs_to :requests
  belongs_to :items
end
