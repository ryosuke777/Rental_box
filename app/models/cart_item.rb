class CartItem < ApplicationRecord
  belongs_to :group
  belongs_to :item, optional: true
end
