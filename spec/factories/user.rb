FactoryBot.define do
  # factory :admin, class: User do
  #   name{Faker::Name.name}
  #   email{Faker::Internet.email}
  #   password{"123456"}
  #   phone{Faker::PhoneNumber.phone}
  #   address{Faker::Address.address}
  #   role{"admin"}
  # end

  factory :user do
    name{Faker::Name.name}
    email{Faker::Internet.email}
    password{"123456"}
    phone{Faker::PhoneNumber.phone_number}
    # phone{"0986123456"}
    address{Faker::Address.full_address}
  end
end
