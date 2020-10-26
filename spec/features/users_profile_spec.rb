require 'rails_helper'

RSpec.feature "UsersProfiles", type: :feature do
  describe 'visiting profile page' do
    let(:user) { FactoryBot.build(:user) }
    before { user.save }

    context 'without signing in' do
      before { visit user_path(user) }

      it 'redirects to login' do
        expect(current_path).to eq('/users/sign_in')
      end

      it 'shows login page with title' do
        expect(page).to have_title("Sign In | Ruby on Rails Social Scaffold")
      end
    end

    context 'when signed in' do

      before do
        visit '/users/sign_in'
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Log in"
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

    describe "having recent posts" do
      before do
        visit '/users/sign_in'
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Log in"

        32.times do |n|
          fill_in 'Content', with: Faker::Lorem.sentence(word_count: 5)
          click_button 'Save'
        end
        visit user_path(user)
      end

      # it "should display recent posts" do
      #   expect(page).to have_button('Comment')
      # end

      it "should display recent posts" do
        expect(page).to have_button('Comment')
      end
    end

    # describe 'friendships buttons' do
      
    #   context 'friend requests' do
    #     # it 'should'
    #   end

    #   context 'friends' do
        
    #   end

    #   context 'pending friends' do
        
    #   end
    # end
  end
end


# it 'should have a new post field' do
#   expect(page).to have_css('input', id: 'post_content')
# end