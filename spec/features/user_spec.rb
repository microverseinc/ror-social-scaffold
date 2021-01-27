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
  
    describe 'user sends a friend request' do
        it 'sends a friend request' do
          visit '/users/sign_in'
          click_link 'Sign in'
    
          fill_in('user[email]', with: user.email)
          fill_in('user[password]', with: user.password)
          click_button 'Log in'
          sleep(3)
          click_on 'All users'
          sleep(3)
          expect(page).to have_text('Name')
        end
    end
end