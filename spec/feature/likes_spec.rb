require 'rails_helper'

feature 'create a like' do
  before(:each) do
    @user = User.create!(name: 'Test3',
                         email: 'test3@example.com',
                         password: 'cake,biscuitsandtea')
    sign_in @user
    @posts = Post.create!(user_id: @user.id, content: 'Post Content here')
    visit posts_path
  end

  scenario 'has a create like section' do
    visit posts_path
    expect(page).to have_content 'Recent posts'
  end

  feature 'create a new like' do
    before(:each) do
      click_on 'Like!'
    end

    scenario 'renders comment section on the post' do
      expect(page).to have_content 'You liked a post'
    end
  end

  feature 'create a dislike' do
    before(:each) do
      click_on 'Like!'
      click_on 'Dislike!'
    end

    scenario 'renders comments section' do
      expect(page).to have_content 'You disliked a post'
    end
  end
end
