FactoryBot.define do
  factory :post do
    user
    content { 'This is post message' }
  end
end
