FactoryBot.define do
    factory :user do
      name { "John Doe" }
      email { "john@gmail.com" }
      password { "12345678Test" }
      password_confirmation { "12345678Test" }
    end
  end
  