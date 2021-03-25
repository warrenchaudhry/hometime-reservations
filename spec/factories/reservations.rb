FactoryBot.define do
  factory :reservation do
    start_date { Date.tomorrow }
    end_date  { start_date + 2.days }
    nights { 3 }
    guests { 4 }
    adults { 2 }
    children { 2 }
    currency { 'AUD' }
    payout_price { 3800 }
    security_price { 500 }
    total_price { 4500 }
    status { 'accepted'}
  end
end
