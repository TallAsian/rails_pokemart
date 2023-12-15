class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "is not a valid email address" }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?

  def self.ransackable_attributes(auth_object = nil)
    ["email", "id", "current_sign_in_at", "sign_in_count", "created_at"]
  end

  private

  def password_required?
    new_record? || password.present?
  end
end