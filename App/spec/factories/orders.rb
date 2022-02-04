FactoryBot.define do
  factory :order do
    association :user

    weight { 1 }
    length { 1 }
    width { 1 }
    height { 1 }
    distance { 1 }
    origin_location { 'Moscow' }
    destination_location { 'Moscow' }
    price { 1 }
    aasm_state { :registered }
  end
end
