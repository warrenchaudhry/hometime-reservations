class ProcessReservation

  attr_reader :payload

  def initialize(payload)
    @payload = payload.to_h
  end

  def call
    process_guest
    reservation = create_reservation
    reservation
  end

  def process_guest
    guest = nil
    ActiveRecord::Base.transaction do
      guest = current_guest
      check_phone_numbers
    end
    guest
  end

  def current_guest
    Guest.where(guest_attribs.except(:phone_numbers)).first_or_create
  end

  def check_phone_numbers
    return unless guest_attribs[:phone_numbers].any?
    guest_attribs[:phone_numbers].each do |phone|
      current_guest.phone_numbers.where(number: phone).first_or_create
    end
  end

  def guest_attribs
    attribs = {}
    if payload.has_key?(:guest)
      guest_payload = payload.fetch(:guest)
      attribs = guest_payload.except(:phone)
      attribs[:phone_numbers] = [guest_payload[:phone]]
    else
      attribs[:email] = payload[:guest_email]
      attribs[:first_name] = payload[:guest_first_name]
      attribs[:last_name] = payload[:guest_last_name]
      attribs[:phone_numbers] = payload[:guest_phone_numbers].uniq      
    end
    attribs
  end

  def create_reservation
    res = Reservation.new(reservation_attrs)
    res.guest_id = current_guest.id
    res.save
    res
  end

  def reservation_attrs
    reservation_attribs = {}
    if payload.has_key?(:guest)
      reservation_attribs = payload.except(:guest)
    else
      reservation_attribs = payload.slice(:start_date, :end_date, :nights)
      reservation_attribs[:guests] = payload[:number_of_guests]
      reservation_attribs[:description] = payload[:guest_details][:localized_description]
      reservation_attribs[:adults] = payload[:guest_details][:number_of_adults]
      reservation_attribs[:children] = payload[:guest_details][:number_of_children]
      reservation_attribs[:infants] = payload[:guest_details][:number_of_infants]
      reservation_attribs[:currency] = payload[:host_currency]
      reservation_attribs[:payout_price] = payload[:expected_payout_amount]
      reservation_attribs[:security_price] = payload[:listing_security_price_accurate]
      reservation_attribs[:total_price] = payload[:total_paid_amount_accurate]
      reservation_attribs[:status] = payload[:status_type]      
    end
    reservation_attribs
  end

end