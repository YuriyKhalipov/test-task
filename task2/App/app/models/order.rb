class Order < ApplicationRecord

  validates :last_name, presence:true
  validates :first_name, presence:true
  validates :patronymic, presence:true
  validates :phone, presence:true
  validates :email, presence:true
  validates :weight, presence:true, numericality: true
  validates :length, presence:true, numericality: { only_integer: true }
  validates :width, presence:true, numericality: { only_integer: true }
  validates :height, presence:true, numericality: { only_integer: true }
  validates :distance, presence:true
  validates :origin_location, presence:true
  validates :destination_location, presence:true
  validates :price, presence:true
end
