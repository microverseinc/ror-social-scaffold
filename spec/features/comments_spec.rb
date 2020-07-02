require 'rails_helper'

feature 'create a comment' do
  before(:each) do
    @user = User.create!(name: 'Test2',
                         email: 'test2@example.com',
                         password: 'cake,biscuitsandtea')
    sign_in @user
    @posts = Post.create!(user_id: @user.id, content: 'Post Content here')
    visit posts_path
  end

  scenario 'has a create comment section' do
    visit posts_path
    expect(page).to have_content 'Recent posts'
  end

  feature 'create a new comment' do
    before(:each) do
      fill_in 'comment_content', with: 'Comment content here'
      click_on 'Comment'
    end

    scenario 'renders comment section on the post' do
      expect(page).to have_content 'Comment content here'
    end
  end

  feature 'create a new post with invalid params' do
    before(:each) do
      fill_in 'comment_content', with: ''
      click_on 'Save'
    end

    scenario 'renders comments could not be saved error' do
      expect(page).to have_content "Content can't be blank"
    end
  end
end
