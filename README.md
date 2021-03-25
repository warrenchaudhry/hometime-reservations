# Hometime Skills Assessment
Hometime Reservations API test.

You should have the following installed to be able to test this application locally:
  * rvm or rbenv
  * ruby 2.6.6
  * node
  * yarn

# Installation
  * `git clone https://github.com/warrenchaudhry/hometime-reservations.git`
  * `cd hometime-reservations`
  * `bundle install`
  * `yarn install`
  * `rails db:create`
  * `rails db:migrate`

# Run the application
  * `rails s` 

# Run the tests
  * `rspec`

# Reservation's Endpoint
## Create a reservation
  **Endpoint:** `POST /api/v1/reservations`
  
  **Headers:** 
    - `Content-Type:application/json`
    - `Authorization: Token sample-token` # note `sample-token` is just a temporary token just to have something for token verification


## Test request

### For payload format 1
```json
{
  "reservation": {
    "start_date": "2020-03-12",
    "end_date": "2020-03-16",
    "expected_payout_amount": "3800.00",
    "guest_details": {
      "localized_description": "4 guests",
      "number_of_adults": 2,
      "number_of_children": 2,
      "number_of_infants": 0
    },
    "guest_email": "wayne_woodbridge@bnb.com",
    "guest_first_name": "Wayne",
    "guest_id": 1,
    "guest_last_name": "Woodbridge",
    "guest_phone_numbers": [
      "639123456789",
      "639123456789"
    ],
    "listing_security_price_accurate": "500.00",
    "host_currency": "AUD",
    "nights": 4,
    "number_of_guests": 4,
    "status_type": "accepted",
    "total_paid_amount_accurate": "4500.00",
  }
}
```

**Sample `curl` request**

```
curl --header "Content-Type: application/json" \
  --header "Authorization: Token sample-token" \
  --request POST \
  --data "{\"reservation\":{\"start_date\":\"2020-03-12\",\"end_date\":\"2020-03-16\",\"expected_payout_amount\":3800.0,\"guest_details\":{\"localized_description\":\"4 guests\",\"number_of_adults\":2,\"number_of_children\":2,\"number_of_infants\":0},\"guest_email\":\"wayne_woodbridge@bnb.com\",\"guest_first_name\":\"Wayne\",\"guest_id\":1,\"guest_last_name\":\"Woodbridge\",\"guest_phone_numbers\":[\"639123456789\",\"639123456789\"],\"listing_security_price_accurate\":500.0,\"host_currency\":\"AUD\",\"nights\":4,\"number_of_guests\":4,\"status_type\":\"accepted\",\"total_paid_amount_accurate\":4500.0}}" \
  http://localhost:3000/api/reservations

```

### For payload format 2

```json
{ 
  "start_date": "2020-03-12", 
  "end_date": "2020-03-16", 
  "nights": 4, 
  "guests": 4, 
  "adults": 2, 
  "children": 2, 
  "infants": 0, 
  "status": "accepted", 
  "guest": { 
    "id": 1, 
    "first_name": "Wayne", 
    "last_name": "Woodbridge", 
    "phone": "639123456789", 
    "email": "wayne_woodbridge@bnb.com" 
  }, 
  "currency": "AUD", 
  "payout_price": "3800.00", 
  "security_price": "500", 
  "total_price": "4500.00" 
}

```

**Sample `curl` request**

```
curl --header "Content-Type: application/json" \
  --header "Authorization: Token sample-token" \
  --request POST \
  --data "{\"start_date\":\"2020-03-12\",\"end_date\":\"2020-03-16\",\"nights\":\"4\",\"guests\":\"4\",\"adults\":\"2\",\"children\":\"2\",\"infants\":\"0\",\"status\":\"accepted\",\"guest\":{\"id\":1,\"first_name\":\"Wayne\",\"last_name\":\"Woodbridge\",\"phone\":\"639123456789\",\"email\":\"wayne_woodbridge@bnb.com\"},\"currency\":\"AUD\",\"payout_price\":\"3800.00\",\"security_price\":\"500\",\"total_price\":\"4500.00\"}" \
  http://localhost:3000/api/reservations
