FactoryBot.define do
  factory :comment do
    user
    post
    content { 'This is comment message' }
  end
end
