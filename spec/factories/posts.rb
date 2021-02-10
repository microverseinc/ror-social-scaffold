FactoryBot.define do
  factory :post do
    user
    content { 'This is a post' }
  end
end
