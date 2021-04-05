class Request < ApplicationRecord
 attachment :image
 validates :date, presence: true
 validates :item_for_sale, presence: true
 has_many :order_items
 has_many :order_gases
 has_many :request_bring_in_equipments
 belongs_to :group
end
