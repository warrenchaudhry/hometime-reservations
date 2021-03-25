class Reservation < ApplicationRecord
  validates :start_date, :end_date, :nights, :adults, :currency, :payout_price, :security_price, :total_price, presence: :true
  belongs_to :guest
  before_save :set_description

  private
  def set_description
    return if self.description.present?
    return if guests.blank?
    self.description = [self.guests, (self.guests > 1 ? 'guests' : 'guest')].join(' ')
  end
end
