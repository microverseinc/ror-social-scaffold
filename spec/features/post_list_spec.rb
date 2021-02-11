require 'rails_helper'

RSpec.describe 'PostLists', type: :feature do
  it 'lists all the posts' do
    user = create(:user)
    article = create(:post, user: user)
    feature_sign_in(user)
    visit posts_path

    expect(page).to have_text(article.content)
  end

  it 'should show a comment form' do
    user = create(:user)
    create(:post)
    feature_sign_in(user)
    visit posts_path

    expect(page).to have_css("input[type='text']")
  end
end
