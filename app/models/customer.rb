class Customer < ApplicationRecord
  belongs_to :provinces
  has_many :orders

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
