class Request < ApplicationRecord
 has_many :order_items
 belongs_to :group
end
