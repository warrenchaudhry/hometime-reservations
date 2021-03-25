module Api::V1
  class ReservationsController < BaseController
    def create
      res = ProcessReservation.new(reservation_params).call
      # I opted not to use activemodel serializers here to save time
      render json: { reservation: res.as_json(include: [:guest]) }
    rescue StandardError => e
      Rails.logger.error e.message
      render json: { error: { message: 'Unable to save reservation.', description: e.message } }, status: 402
    end

    private
    def reservation_params
      params.fetch(:reservation, {}).has_key?(:guest_details) ? permit_reservation_params_one : permit_reservation_params_two 
    end

    def permit_reservation_params_one
      params.require(:reservation).permit(
        :start_date,
        :end_date,
        :expected_payout_amount,
        :guest_email,
        :guest_first_name,
        :guest_last_name,
        :listing_security_price_accurate,
        :host_currency,
        :nights,
        :number_of_guests,
        :status_type,
        :total_paid_amount_accurate,
        guest_phone_numbers: [],
        guest_details: [
          :localized_description,
          :number_of_adults,
          :number_of_children,
          :number_of_infants,
        ]
      )
    end

    def permit_reservation_params_two
      params.permit(
        :start_date,
        :end_date,
        :nights,
        :guests,  
        :adults,
        :children,
        :infants,
        :status,
        :currency,
        :payout_price,
        :security_price,
        :total_price,
        guest: [
          :first_name,
          :last_name,
          :phone,
          :email,
        ]
      )
    end
  end
end
