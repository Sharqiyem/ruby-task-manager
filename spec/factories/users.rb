FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password123" } # Or use a secure, random password
    password_confirmation { "password123" } # Match password

    # Add any other required attributes for your User model here
  end
end