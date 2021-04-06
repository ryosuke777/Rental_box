class Item < ApplicationRecord
  attachment :image
  validates :name, presence: true
  validates :price, presence: true
  validates :add_price, presence: true
  validates :introduction, presence: true

  has_many :cart_items
  has_many :order_items
  belongs_to :genre
end
