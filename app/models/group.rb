class Group < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :cart_items
  has_many :bring_in_equipments
  has_many :gas_requests
  has_one :request
  has_many :order_items, through: :request
  has_many :order_gases, through: :request
end
