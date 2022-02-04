class User < ApplicationRecord
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, presence:true, length: {maximum: 50}
  validates :first_name, presence:true, length: {maximum: 50}
  validates :patronymic, presence:true, length: {maximum: 50}
  validates :phone, presence:true, length: {maximum: 15}

  mount_uploader :avatar, AvatarUploader
end
