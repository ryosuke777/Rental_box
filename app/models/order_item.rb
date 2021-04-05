class OrderItem < ApplicationRecord
  belongs_to :request
  belongs_to :item
  delegate :group, to: :request
end
