require 'rails_helper'

RSpec.feature 'UsersLogins', type: :feature do
  describe 'signin page' do
    before { visit '/users/sign_in' }

    it 'should have a title' do
      expect(page).to have_title('Sign In | Ruby on Rails Social Scaffold')
    end

    it 'should have a heading sign in' do
      expect(page).to have_selector('h2', text: 'Sign in')
    end

    it 'should have a sign in button' do
      expect(page).to have_button('Log in')
    end
  end

  describe 'signin' do
    let(:user) { FactoryBot.build(:user) }
    before do
      user.save
      visit '/users/sign_in'
    end

    context 'with invalid information' do
      before { click_button 'Log in' }

      it 'should have a title' do
        expect(page).to have_title('Sign In | Ruby on Rails Social Scaffold')
      end

      it 'should display error message' do
        expect(page).to have_selector('div.alert.alert', text: 'Invalid Email or password.')
      end

      it 'should not display user Avatar' do
        expect(page).to_not have_css('img.gravatar')
      end

      it 'should not display user info' do
        expect(page).to_not have_link(user.name, href: user_path(user))
      end
    end

    context 'with valid information' do
      before do
        fill_in 'Email', with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Log in'
      end

      it 'should display login success message' do
        expect(page).to have_selector('div.alert.alert-notice', text: 'Signed in successfully.')
      end

      it 'shows user page with title' do
        visit user_path(user)
        expect(page).to have_title("#{user.name} | Ruby on Rails Social Scaffold")
      end

      it 'should display user Avatar' do
        expect(page).to have_css('img.gravatar')
      end

      it 'should display user info' do
        expect(page).to have_link(user.name, href: "/users/#{user.id}")
      end

      it 'displays new post input field' do
        expect(page).to have_css('input', id: 'post_content')
      end
    end

    context 'with valid information followed by logout' do
      before do
        fill_in 'Email', with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Log in'
      end

      it 'redirects to login' do
        click_link 'Sign out'
        # expect(page).to have_current_path(new_user_session_path)
        expect(current_path).to eq(new_user_session_path)
      end

      it 'page should have s sign in button' do
        click_link 'Sign out'
        expect(page).to have_selector(:button, 'Log in')
      end
    end
  end
end
