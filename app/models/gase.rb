class Gase < ApplicationRecord
    has_many :gas_requests
    has_many :order_gases
end
