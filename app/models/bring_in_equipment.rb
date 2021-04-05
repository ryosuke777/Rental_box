class BringInEquipment < ApplicationRecord
  validates :name, presence: true
  validates :amount, presence: true
  validates :power_consumption, presence: true
  belongs_to :group
end
