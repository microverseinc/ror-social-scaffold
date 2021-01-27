require_relative '../rails_helper'

RSpec.describe 'webpage workflow', type: :system do
  let(:user) do
    User.create(name: 'Magz',
                email: 'magz@example.com',
                password: '123456',
                password_confirmation: '123456')
  end

  let(:user1) do
    User.create(name: 'Jocy',
                email: 'jocy@example.com',
                password: '123456',
                password_confirmation: '123456')
  end

  let(:post) { Post.create(user_id: user1.id, content: 'This is my first post') }
  let(:comment) { Comment.create(user_id: user1.id, content: 'This is my first comment') }
  describe 'Add comment' do
    it 'Add comment on post' do
      visit '/users/sign_in'
      click_link 'Sign in'

      fill_in('user[email]', with: user.email)
      fill_in('user[password]', with: user.password)
      click_button 'Log in'
      sleep(3)
      fill_in 'post[content]', with: 'This is my first post'
      click_on 'Save'
      sleep(5)
      fill_in 'comment[content]', with: 'This is my first comment'
      click_button 'Comment'
      sleep(3)
      expect(page).to have_content('Comment was successfully created.')
    end
  end
end
