class Guest < ApplicationRecord
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  has_many :reservations
  has_many :phone_numbers
  validates :email, :first_name, :last_name, presence: true
  validates_format_of :email, with: VALID_EMAIL_REGEX, allow_blank: true
  validates_uniqueness_of :email, case_sensitive: false, allow_blank: true

  def full_name
    [first_name, last_name].compact.join(' ')
  end
end
