FactoryBot.define do
  factory :user do
    last_name { FFaker::Name.last_name }
    first_name { FFaker::Name.name }
    patronymic { FFaker::Name.name }
    email { FFaker::Internet.email }
    phone { '1234567890' }
    password { 'password'}
    password_confirmation { 'password'}
  end
end