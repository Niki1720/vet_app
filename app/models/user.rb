class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable
  include DeviseTokenAuth::Concerns::User
  has_many :animals, dependent: :destroy
  has_secure_password

  validates :first_name, presence: true, length: { minimum: 3, maximum: 20 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 20 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 105 }
end
