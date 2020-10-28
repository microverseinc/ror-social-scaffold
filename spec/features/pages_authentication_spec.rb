require 'rails_helper'

RSpec.feature 'PagesAuthentications', type: :feature do
  describe 'GET /users' do
    let(:user) { FactoryBot.create(:user) }

    context 'when not signed in' do
      it 'should redirect to login page' do
        visit '/users'
        expect(current_path).to eq('/users/sign_in')
      end
    end

    context 'when signed in' do
      before do
        visit '/users'
        fill_in 'Email', with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Log in'
      end

      it 'should show index page' do
        expect(current_path).to eq('/users')
      end
    end
  end

  describe 'GET /users/1' do
    let(:user) { FactoryBot.create(:user) }

    context 'when not signed in' do
      it 'should redirect to login page' do
        visit user_path(user)
        expect(current_path).to eq('/users/sign_in')
      end
    end

    context 'when signed in' do
      before do
        visit user_path(user)
        fill_in 'Email', with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Log in'
      end

      it 'should show user profile page' do
        expect(current_path).to eq(user_path(user))
      end
    end
  end

  describe 'GET /posts/' do
    let(:user) { FactoryBot.create(:user) }

    context 'when not signed in' do
      it 'should redirect to login page' do
        visit user_path(user)
        expect(current_path).to eq('/users/sign_in')
      end
    end

    context 'when signed in' do
      before do
        visit user_path(user)
        fill_in 'Email', with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Log in'
      end

      it 'should show user profile page' do
        expect(current_path).to eq(user_path(user))
      end
    end
  end

  describe 'GET /friendships?friendship_type=friend' do
    let(:user) { FactoryBot.create(:user) }
    before { visit('/friendships?friendship_type=friend') }

    context 'when not signed in' do
      it 'should redirect to login page' do
        expect(current_path).to eq('/users/sign_in')
      end
    end

    context 'when signed in' do
      before do
        fill_in 'Email', with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Log in'
      end

      it 'should show friendships index page' do
        expect(current_path).to eq('/friendships')
      end
    end
  end

  describe 'GET /friendships?friendship_type=friend_request' do
    let(:user) { FactoryBot.create(:user) }
    before { visit('/friendships?friendship_type=friend_request') }

    context 'when not signed in' do
      it 'should redirect to login page' do
        expect(current_path).to eq('/users/sign_in')
      end
    end

    context 'when signed in' do
      before do
        fill_in 'Email', with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Log in'
      end

      it 'should show friendships index page' do
        expect(current_path).to eq('/friendships')
      end
    end
  end

  describe 'GET /friendships?friendship_type=pending_friend' do
    let(:user) { FactoryBot.create(:user) }
    before { visit('/friendships?friendship_type=pending_friend') }

    context 'when not signed in' do
      it 'should redirect to login page' do
        expect(current_path).to eq('/users/sign_in')
      end
    end

    context 'when signed in' do
      before do
        fill_in 'Email', with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Log in'
      end

      it 'should show friendships index page' do
        expect(current_path).to eq('/friendships')
      end
    end
  end
end
