require 'rails_helper'

RSpec.feature 'UsersProfiles', type: :feature do
  describe 'visiting profile page' do
    let(:user) { FactoryBot.build(:user) }
    before { user.save }

    context 'when not signed in' do
      before { visit user_path(user) }

      it 'redirects to login' do
        expect(current_path).to eq('/users/sign_in')
      end

      it 'shows login page with title' do
        expect(page).to have_title('Sign In | Ruby on Rails Social Scaffold')
      end
    end

    context 'when signed in' do
      before do
        visit '/users/sign_in'
        fill_in 'Email', with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Log in'
        visit user_path(user)
      end

      it 'redirects to user path' do
        expect(page).to have_current_path(user_path(user))
      end

      it 'show usr page with title' do
        expect(page).to have_title(user.name)
      end

      it 'shows user name and Avatar' do
        expect(page).to have_selector('h1', text: user.name)
        expect(page).to have_selector('h1>img.gravatar')
      end
    end

    describe 'when signed in and having recent posts' do
      before do
        visit '/users/sign_in'
        fill_in 'Email', with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Log in'

        35.times do |_n|
          fill_in 'Content', with: Faker::Lorem.sentence(word_count: 5)
          click_button 'Save'
        end
        visit user_path(user)
      end

      it 'should display recent posts' do
        expect(page).to have_selector('p.post-content')
      end

      it 'should display new comment form for each post' do
        expect(page).to have_selector('form#new_comment')
      end

      it 'should add comment button' do
        expect(page).to have_button('Comment')
      end

      it 'should have pagination' do
        expect(page).to have_selector('div.pagination')
      end

      it 'should have a sidebar' do
        expect(page).to have_selector('div#sidebar-wrapper')
      end

      it 'should have friends links in a sidebar' do
        expect(page).to have_selector('div.sidebar-heading', text: 'All Friends')
      end
    end
  end

  describe "visiting another user's page" do
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }
    let(:user3) { FactoryBot.create(:user) }

    before do
      visit '/users/sign_in'
      fill_in 'Email', with: user1.email.upcase
      fill_in 'Password', with: user1.password
      click_button 'Log in'

      fill_in 'Content', with: Faker::Lorem.sentence(word_count: 5)
      click_button 'Save'
      visit user_path(user2)
      click_button 'Add Friend'
      click_link 'Sign out'
      fill_in 'Email', with: user2.email.upcase
      fill_in 'Password', with: user2.password
      click_button 'Log in'
    end

    describe 'when they are not fiends' do
      before { visit user_path(user1) }

      it 'shows Confirm and Delete friend buttons' do
        expect(page).to have_button('Confirm')
        expect(page).to have_button('Delete')
      end

      it 'should not show Friends button' do
        expect(page).not_to have_button('Friends')
      end

      it "they can see each other's posts" do
        expect(page).to have_selector('p.post-content')
      end

      it 'they cannot like any post' do
        expect(page).not_to have_link('Like!')
      end

      it "they can't comment on each other's posts" do
        expect(page).not_to have_selector('form#new_comment')
      end

      it 'they cannot not add comment button' do
        expect(page).not_to have_button('Comment')
      end

      it 'page should not have a sidebar' do
        expect(page).not_to have_selector('div#sidebar-wrapper')
      end

      it 'page should not have friends links in a sidebar' do
        expect(page).not_to have_selector('div.sidebar-heading', text: 'All Friends')
      end
    end

    describe 'when they are fiends' do
      before do
        visit user_path(user1)
        click_button 'Confirm'
      end

      it "should show 'Friends' button" do
        expect(page).to have_selector('div.already-friends-button', text: 'Friends')
      end

      it 'should not show Confirm and Delete friend buttons' do
        expect(page).not_to have_button('Confirm')
        expect(page).not_to have_button('Delete')
      end

      it "they can see each other's posts" do
        expect(page).to have_selector('p.post-content')
      end

      it 'they can like any post' do
        expect(page).to have_link('Like!', count: 1)
      end

      context 'both friends' do
        before { first('.post-liking').click_link 'Like!' }

        it 'can like any post' do
          expect(page).not_to have_link('Like!')
        end

        it 'can dislike any post' do
          expect(page).to have_link('Dislike!', count: 1)
        end

        it 'can dislike any post' do
          first('.post-liking').click_link 'Dislike!'
          expect(page).to have_link('Like!', count: 1)
        end
      end

      it "they can comment on each other's posts" do
        expect(page).to have_selector('form#new_comment', count: 1)
      end

      it 'they can add comment button' do
        expect(page).to have_button('Comment', count: 1)
      end

      context 'with new comment' do
        before do
          find('input#comment_content').set('New comment')
          click_button 'Comment'
        end

        it 'page should show comment author' do
          expect(page).to have_selector('p>b>a', text: user2.name, count: 1)
        end

        it 'page should show new comment' do
          expect(page).to have_selector('p', text: 'New comment')
        end
      end

      it 'page should not have a sidebar' do
        expect(page).not_to have_selector('div#sidebar-wrapper')
      end

      it 'page should not have friends links in a sidebar' do
        expect(page).not_to have_selector('div.sidebar-heading', text: 'All Friends')
      end
    end

    context 'with pending (sent) request' do
      before do
        visit user_path(user3)
        click_button 'Add Friend'
      end
      it 'should show pending request button' do
        expect(page).to have_button('Cancel Request')
      end

      it 'should be able to cancel friend request' do
        click_button 'Cancel Request'
        expect(page).not_to have_button('Cancel Request')
        expect(page).to have_button('Add Friend')
      end
    end
  end
end
