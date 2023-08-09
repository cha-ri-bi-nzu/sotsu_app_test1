class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_many :sesired_holidays
  has_many :shifts
  has_many :groupings, dependent: :destroy
  has_many :groups, through: :groupings, source: :group
end
