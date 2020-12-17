require 'rails_helper'

# rspec spec/views/user_spec.rb
RSpec.describe 'Create post', type: :system do
  let(:test_user) { User.create(name: 'User Test', email: 'user@example.com', password: 'password') }

  describe 'create post' do
    it 'path is correct' do
      test_user
      visit('/')
      fill_in('user[email]', with: 'user@example.com')
      fill_in('user[password]', with: 'password')
      click_button('Log in')
      fill_in('post[content]', with: 'this is an example post')
      click_button('Save')
      click_link('Like!', match: :first)
    end
  end
end
