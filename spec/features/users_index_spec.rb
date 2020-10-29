require 'rails_helper'

RSpec.feature 'UsersIndices', type: :feature do
  describe 'index page' do
    let(:user) { FactoryBot.create(:user) }

    describe 'without friend requests or pending friends' do
      before do
        32.times do
          FactoryBot.create(:user)
        end
        visit '/users/sign_in'
        fill_in 'Email', with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Log in'
        click_link 'All users'
      end

      it 'should have a heading' do
        expect(page).to have_selector('h1', text: 'All users', count: 1)
      end

      it 'should have pagination' do
        expect(page).to have_selector('div.pagination')
      end

      it 'should have profile image tag (30 per page)' do
        expect(page).to have_selector('div>img.gravatar', count: 30)
      end

      it 'should have profile name link (30 per page)' do
        expect(page).to have_selector('li.friend-response>div>a', count: 30)
      end

      it 'should have a button to add each friend' do
        expect(page).to have_button('Add Friend', count: 30)
      end

      it 'should have a sidebar' do
        expect(page).to have_selector('div#sidebar-wrapper')
      end

      it 'should have friends links in a sidebar' do
        expect(page).to have_selector('div.sidebar-heading', text: 'All Friends')
      end
    end

    describe 'with pending friends and friend requests' do
      before do
        10.times do
          visit '/users/sign_in'
          u = FactoryBot.create(:user)
          fill_in 'Email', with: u.email.upcase
          fill_in 'Password', with: u.password
          click_button 'Log in'
          visit user_path(user)
          click_button 'Add Friend'
          click_link 'Sign out'
        end

        10.times do
          FactoryBot.create(:user)
        end
        visit '/users/sign_in'
        fill_in 'Email', with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Log in'
        click_link 'All users'
      end

      it 'should have profile image tag (21 users)' do
        expect(page).to have_selector('div>img.gravatar', count: 21)
      end

      it 'should have profile name linl (21 users)' do
        expect(page).to have_selector('li.friend-response>div>a', count: 21)
      end

      it 'should have a button to add each friend' do
        expect(page).to have_button('Add Friend', count: 10)
      end
    end
  end
end
