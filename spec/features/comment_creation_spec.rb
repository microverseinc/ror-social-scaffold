require 'rails_helper'

RSpec.describe 'CommentCreations', type: :feature do
  it 'should redirect to post index page after commenting' do
    article = create(:post)
    feature_sign_in(article.user)
    visit posts_path
    fill_in 'comment_content', with: 'This is a good post'
    click_button 'Comment'

    expect(page).to have_text('This is a good post')
  end

  it 'should show error message if fields are invalid' do
    article = create(:post)
    feature_sign_in(article.user)
    visit posts_path
    click_button 'Comment'

    expect(page).to have_text("Content can't be blank")
  end
end
