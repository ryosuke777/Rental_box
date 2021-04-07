class OrderGase < ApplicationRecord
  belongs_to :request
  belongs_to :gase
  delegate :group, to: :request
end
