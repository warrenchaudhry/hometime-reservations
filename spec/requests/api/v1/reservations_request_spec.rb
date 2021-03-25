require "rails_helper"

RSpec.describe 'Reservations API', type: :request do

  let(:headers) { { 'Authorization' => 'Token sample-token', 'Content-Type' => 'application/json' } }
  let(:payload_one) {
    {
      reservation: { 
        start_date: "2020-03-12",
        end_date: "2020-03-16",
        expected_payout_amount: 3800.00,
        guest_details: {
          localized_description: "4 guests",
          number_of_adults: 2,  
          number_of_children: 2,
          number_of_infants: 0
        }, 
        guest_email: "wayne_woodbridge@bnb.com",
        guest_first_name: "Wayne",
        guest_id: 1,
        guest_last_name: "Woodbridge",
        guest_phone_numbers: [
          "639123456789",
          "639123456789"
        ],
        listing_security_price_accurate: 500.00,
        host_currency: "AUD",
        nights: 4,
        number_of_guests: 4,
        status_type: "accepted",
        total_paid_amount_accurate: 4500.00
      }
    }
  }

  let(:payload_two) {
    { 
      start_date: "2020-03-12",
      end_date: "2020-03-16",
      nights: "4",
      guests: "4",
      adults: "2",
      children: "2",
      infants: "0",
      status: "accepted",
      guest: {
        id: 1,
        first_name: "Wayne",
        last_name: "Woodbridge",
        phone: "639123456789",
        email: "wayne_woodbridge@bnb.com"
      },
      currency: "AUD",
      payout_price: "3800.00",
      security_price: "500",
      total_price: "4500.00"
    }
  }

  describe 'POST /api/v1/reservations' do
    context "when using payload format 1" do
      describe 'and reservation is successfully saved' do
        it 'returns http success' do
          post api_v1_reservations_url, params: payload_one.to_json, headers: headers
          expect(response).to have_http_status(200)
        end

        it 'will add a new record of reservation' do
          expect {
            post api_v1_reservations_url, params: payload_one.to_json, headers: headers
          }.to change { Reservation.count }.by(1)
        end

        it 'returns a json with the reservation_record details' do
          post api_v1_reservations_url, params: payload_one.to_json, headers: headers
          reservation = Reservation.last
          json = JSON.parse(response.body).deep_symbolize_keys
          expect(json).to have_key(:reservation)
          expect(json[:reservation][:id]).to eq(reservation.id)
          expect(json[:reservation]).to have_key(:guest)
        end

        it 'should contain correct details' do
          post api_v1_reservations_url, params: payload_one.to_json, headers: headers
          reservation = Reservation.last
          expect(reservation.description).to eq('4 guests')
          expect(reservation.start_date.to_s).to eq(payload_one[:reservation][:start_date])
          expect(reservation.end_date.to_s).to eq(payload_one[:reservation][:end_date])
          expect(reservation.nights).to eq(payload_one[:reservation][:nights].to_i)
          expect(reservation.guest.email).to eq('wayne_woodbridge@bnb.com')
          expect(reservation.guest.phone_numbers.size).to eq(1)
        end
      end
    end

    context "when using payload format 2" do
      describe 'and reservation is successfully saved' do
        it 'returns http success' do
          post api_v1_reservations_url, params: payload_two.to_json, headers: headers
          expect(response).to have_http_status(200)
        end

        it 'will add a new record of reservation' do
          expect {
            post api_v1_reservations_url, params: payload_two.to_json, headers: headers
          }.to change { Reservation.count }.by(1)
        end

        it 'returns a json with the reservation_record details' do
          post api_v1_reservations_url, params: payload_two.to_json, headers: headers
          reservation = Reservation.last
          json = JSON.parse(response.body).deep_symbolize_keys
          expect(json).to have_key(:reservation)
          expect(json[:reservation][:id]).to eq(reservation.id)
          expect(json[:reservation]).to have_key(:guest)
        end

        it 'should contain correct details' do
          post api_v1_reservations_url, params: payload_two.to_json, headers: headers
          reservation = Reservation.last
          expect(reservation.description).to eq('4 guests')
          expect(reservation.start_date.to_s).to eq(payload_two[:start_date])
          expect(reservation.end_date.to_s).to eq(payload_two[:end_date])
          expect(reservation.nights).to eq(payload_two[:nights].to_i)
          expect(reservation.guest.email).to eq('wayne_woodbridge@bnb.com')
          expect(reservation.guest.phone_numbers.size).to eq(1)
        end
      end
    end

    context "when an error occured" do
      before { allow_any_instance_of(ProcessReservation).to receive(:call).and_raise(StandardError) }
      it 'returns a 402 http status code' do
        post api_v1_reservations_url, params: payload_two.to_json, headers: headers
        expect(response).to have_http_status(402)
      end

      it 'returns a json response with the error details' do
        post api_v1_reservations_url, params: payload_two.to_json, headers: headers
        json = JSON.parse(response.body).deep_symbolize_keys
        expect(json[:error][:message]).to eq('Unable to save reservation.')
      end
    end
  end
end