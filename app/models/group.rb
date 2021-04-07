class Group < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :group_name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :email, presence: true
  validates :group_name_kana, presence: true
  validates :representative_name, presence: true
  validates :representative_name_kana, presence: true
  validates :representative_telephone_number, presence: true
  validates :subdelegate_name, presence: true
  validates :subdelegate_name_kana, presence: true
  validates :subdelegate_telephone_number, presence: true
  validates :subdelegate_email, presence: true
  has_many :cart_items
  has_many :bring_in_equipments
  has_many :gas_requests
  has_one :request
  has_many :order_items, through: :request
  has_many :order_gases, through: :request
end
