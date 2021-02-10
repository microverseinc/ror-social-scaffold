FactoryBot.define do
  factory :comment do
    user
    post
    content { 'This is a comment' }
  end
end
