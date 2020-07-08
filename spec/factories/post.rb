FactoryBot.define do
  factory :random_post, class: 'Post' do
    user_id { 1 }
    content { Faker::Movies::BackToTheFuture.quote }
  end
end
