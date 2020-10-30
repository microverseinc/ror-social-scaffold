require 'rails_helper'

RSpec.feature 'UsersSignups', type: :feature do
  describe 'Signup' do
    before do
      visit '/users/sign_up'
      fill_in 'Name', with: 'Example User'
      fill_in 'Email', with: nil
      fill_in 'Password', with: 'foobar'
    end

    it 'page should have a title' do
      expect(page).to have_title('Sign up | Ruby on Rails Social Scaffold')
    end

    context 'form' do
      it 'should have a name field' do
        expect(page).to have_field('Name')
      end

      it 'should have an email field' do
        expect(page).to have_field('Email')
      end

      it 'should have a password field' do
        expect(page).to have_field('Password')
      end
    end

    context 'failiure' do
      it 'should display failiure message' do
        click_button 'Sign up'
        expect(page).to have_text('errors prohibited this user from being saved:')
      end

      it 'should display failiure message' do
        click_button 'Sign up'
        expect(page).to have_text("Email can't be blank")
      end
    end

    context 'Success' do
      before { fill_in 'Email', with: 'user@example.com' }

      it 'Create new user' do
        expect { click_button 'Sign up' }.to change { User.count }.by(1)
      end

      it 'should display success message' do
        click_button 'Sign up'
        expect(page).to have_text('Welcome! You have signed up successfully.')
      end
    end
  end
end
