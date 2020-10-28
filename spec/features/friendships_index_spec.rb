require 'rails_helper'

RSpec.feature 'FriendshipsIndices', type: :feature do
  describe 'index page' do
    let(:user) { FactoryBot.create(:user) }
    before do
      32.times do
        visit '/users/sign_in'
        u = FactoryBot.create(:user)
        fill_in 'Email', with: u.email.upcase
        fill_in 'Password', with: u.password
        click_button 'Log in'
        visit user_path(user)
        click_button 'Add Friend'
        click_link 'Sign out'
      end

      visit '/users/sign_in'
      fill_in 'Email', with: user.email.upcase
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end

    context 'friend requests' do
      before { click_link 'Friend Requests' }

      it 'should display correct friend request stats' do
        expect(page).to have_content('32 Friend Requests')
      end

      it 'should be able to update friend request stats after deleting one request' do
        first('input.delete').click
        expect(page).to have_content('31 Friend Requests')
      end

      it 'should have the correct heading' do
        expect(page).to have_selector('h1', text: 'Friend Requests', count: 1)
      end

      it 'should have correct profile image count (30 per page)' do
        expect(page).to have_selector('div>img.gravatar', count: 30)
      end

      it 'should have profile name link count (30 per page)' do
        expect(page).to have_selector('li.friend-response>div>a', count: 30)
      end

      it 'should have a button to confirm each friend' do
        expect(page).to have_button('Confirm', count: 30)
      end

      it 'should have a button to delete each request' do
        expect(page).to have_button('Delete', count: 30)
      end

      it 'should have a sidebar' do
        expect(page).to have_selector('div#sidebar-wrapper')
      end

      it 'should have friends links in a sidebar' do
        expect(page).to have_selector('div.sidebar-heading', text: 'All Friends')
      end

      it 'should have pagination' do
        expect(page).to have_selector('div.pagination')
      end
    end

    context 'pending friends' do
      before do
        click_link 'All users'
        10.times do
          FactoryBot.create(:user)
          visit current_path
          click_button 'Add Friend'
        end

        click_link 'Sent Requests'
      end

      it 'should display correct sent requests stats' do
        expect(page).to have_content('10 Sent Requests')
      end

      it 'should be able to update sent requests stats after cancelling one request' do
        first('input.delete').click
        click_link 'Sent Requests'
        expect(page).to have_content('9 Sent Requests')
      end

      it 'should have the correct heading' do
        expect(page).to have_selector('h1', text: 'Pending Friends', count: 1)
      end

      it 'should have correct profile image count (10 per page)' do
        expect(page).to have_selector('div>img.gravatar', count: 10)
      end

      it 'should have correct profile name link count (10 per page)' do
        expect(page).to have_selector('li.friend-response>div>a', count: 10)
      end

      it 'should provide buttons to cancel each request (10 per page)' do
        expect(page).to have_button('Cancel Request', count: 10)
      end

      it 'should have a sidebar' do
        expect(page).to have_selector('div#sidebar-wrapper')
      end

      it 'should have friends links in a sidebar' do
        expect(page).to have_selector('div.sidebar-heading', text: 'All Friends')
      end
    end

    context 'friends' do
      before do
        31.times do
          click_link 'Friend Requests'
          first('input.confirm').click
        end
        click_link 'Friends'
      end

      it 'should have friends links in a sidebar' do
        expect(page).to have_selector('div.sidebar-heading', text: 'All Friends')
      end

      it 'should display correct friends stats' do
        expect(page).to have_content('31 Friends')
      end

      it 'should be able to update friends stats after accepting one request' do
        visit '/friendships?friendship_type=friend_request'
        first('input.confirm').click
        click_link 'Friends'
        expect(page).to have_content('32 Friends')
      end

      it 'should have the correct heading' do
        expect(page).to have_selector('h1', text: 'Friends', count: 1)
      end

      it 'should have correct profile image count (30 per page)' do
        expect(page).to have_selector('div>img.gravatar', count: 30)
      end

      it 'should have the correct Friends buttons count (30 per page)' do
        expect(page).to have_selector('div.already-friends-button', text: 'Friends', count: 30)
      end

      it 'should have correct profile name link count (30 per page)' do
        expect(page).to have_selector('li.friend-response>div>a', count: 30)
      end

      it 'should have a sidebar' do
        expect(page).to have_selector('div#sidebar-wrapper')
      end

      it 'should have pagination' do
        expect(page).to have_selector('div.pagination')
      end
    end
  end
end

# describe 'friends' do
#   let(:user) { FactoryBot.create(:user) }
#   before do
#     50.times do
#       visit '/users/sign_in'
#       u = FactoryBot.create(:user)
#       fill_in 'Email', with: u.email.upcase
#       fill_in 'Password', with: u.password
#       click_button 'Log in'
#       visit user_path(user)
#       click_button 'Add Friend'
#       click_link 'Sign out'
#     end

#     visit '/users/sign_in'
#     fill_in 'Email', with: user.email.upcase
#     fill_in 'Password', with: user.password
#     click_button 'Log in'

#     31.times do
#       click_link 'Friend Requests'
#       first('input.confirm').click
#     end
#     click_link 'Friends'
#   end

#   it 'should display correct friends stats' do
#     expect(page).to have_content('31 Friends')
#   end

#   it 'should be able to update friends stats after accepting one request' do
#     first('input.confirm').click
#     click_link 'Friends'
#     expect(page).to have_content('32 Friends')
#   end

#   it 'should have the correct heading' do
#     expect(page).to have_selector('h1', text: 'Friends', count: 1)
#   end

#   it 'should have correct profile image ount' do
#     expect(page).to have_selector('div>img.gravatar', count: 30)
#   end

#   it 'should have the correct Friends buttons count' do
#     expect(page).to have_selector('div.already-friends-button', text: 'Friends', count: 30)
#   end

#   it 'should have correct profile name link count' do
#     expect(page).to have_selector('li.friend-response>div>a', count: 30)
#   end

#   it 'should have a sidebar' do
#     expect(page).to have_selector('div#sidebar-wrapper')
#   end

#   it 'should have friends links in a sidebar' do
#     expect(page).to have_selector('div.sidebar-heading', text: 'All Friends')
#   end

#   it 'should have pagination' do
#     expect(page).to have_selector('div.pagination')
#   end
# end
