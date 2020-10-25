require 'rails_helper'

RSpec.feature "UsersLogins", type: :feature do

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

  describe "signin" do
    before { visit 'users/sign_in' }

    context "with invalid information" do
      before { click_button "Log in" }

      it 'should have a title' do
        expect(page).to have_title('Sign In | Ruby on Rails Social Scaffold')
      end

      it 'should display error message' do
        expect(page).to have_selector('div.alert.alert', text: 'Invalid Email or password.')
      end
    end

    context 'with valid information' do
      let(:user) { FactoryBot.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Log in"
      end

      it 'should display login success message' do
        expect(page).to have_selector('div.alert.alert-notice', text: 'Signed in successfully.')
      end      
    end

    context 'with valid information followed by logout' do
      let(:user) { FactoryBot.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Log in"
      end

      it 'redirects to login' do
        click_link "Sign out"
        expect(page).to have_current_path(new_user_session_path)
      end

      it 'page should have s sign in button' do
        click_link "Sign out"
        expect(page).to have_selector(:button, 'Log in')
      end
    end   
  end
end
