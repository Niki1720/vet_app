FactoryBot.define do
  factory :user do
    first_name { "Ola" }
    last_name { "Szarek" }
    email { "user@wp.pl" }
    password { "password" }
  end
end
