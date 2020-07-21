FactoryBot.define do
  factory :random_post, class: 'Post' do
    user_id { 1 }
    content { Faker::Movies::BackToTheFuture.quote }
  end

  factory :random_post_list, class: 'Post' do
    sequence(:user_id) { |n| n }
    content { Faker::Movies::BackToTheFuture.quote }
  end
end
