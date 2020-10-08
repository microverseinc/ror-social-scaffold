require 'rails_helper'

RSpec.feature 'Comments', type: :feature do
  login

  scenario 'commenting on a post' do
    visit posts_path
    fill_in 'comment_content', with: 'Yes I am'
    click_on 'Comment'

    expect(page).to have_content 'Comment was successfully created.'
    expect(page).to have_content "#{@user.name}: Yes I am"
  end
end
