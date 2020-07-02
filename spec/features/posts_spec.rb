require 'rails_helper'

feature 'create a post' do
  before(:each) do
    @user = User.create!(name: 'Test1',
                         email: 'test1@example.com',
                         password: 'cake,biscuitsandtea')
    sign_in @user
    visit posts_path
  end

  scenario 'has a create post page' do
    visit posts_path
    expect(page).to have_content 'Recent posts'
  end

  feature 'create a new post' do
    before(:each) do
      fill_in 'post_content', with: 'content here'
      click_on 'Save'
    end

    scenario 'renders post page' do
      expect(page).to have_content 'content here'
    end
  end

  feature 'create a new post with invalid params' do
    before(:each) do
      fill_in 'post_content', with: ''
      click_on 'Save'
    end

    scenario 'renders post could not be saved error' do
      expect(page).to have_content 'Post could not be saved'
    end
  end
end
