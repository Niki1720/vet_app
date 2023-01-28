class Animal < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { minimum: 3}
  validates :species, presence: true

  # instancyjna
  def age_in_months
    (Date.today.month - birth.to_date.month).to_i
  end

  # klasowa
  def self.is_beautiful?
    true
  end
end
