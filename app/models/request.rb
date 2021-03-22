class Request < ApplicationRecord
 attachment :image
 has_many :order_items
 has_many :order_gases
 belongs_to :group
end
