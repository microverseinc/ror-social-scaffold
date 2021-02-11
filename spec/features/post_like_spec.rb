require 'rails_helper'

RSpec.describe 'PostLikes', type: :feature do
  it 'should like the post if the post is unliked' do
    user = create(:user)
    create(:post, user: user)
    feature_sign_in(user)
    visit posts_path
    click_link 'Like'

    expect(page).to have_text('You liked a post')
  end

  it 'should dislike the post if the user has already liked the post' do
    user = create(:user)
    article = create(:post, user: user)
    create(:like, post: article, user: user)
    feature_sign_in(user)
    visit posts_path
    click_link 'Dislike'

    expect(page).to have_text('You disliked a post')
  end
end
