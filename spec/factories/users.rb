FactoryBot.define do
  factory :user do
    name { SecureRandom.hex(10) }
    email { "#{SecureRandom.hex}@#{SecureRandom.hex}.#{SecureRandom.hex}" }
    password { SecureRandom.hex }
  end
end
