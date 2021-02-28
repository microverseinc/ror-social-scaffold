require_relative '../rails_helper.rb'

RSpec.describe 'root page', type: :system do
  describe 'when not signed in' do
    it 'is sign_in page' do
      visit root_path
      expect(page).to have_content 'Sign in'
    end
  end
  describe 'sign_up' do
    it 'signs up a new user' do
      visit new_user_registration_path
      fill_in 'Name', with: 'testing'
      fill_in 'Email', with: 'tea@st.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_on 'Sign up'
      expect(page.current_path).to eq '/'
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end
  end

  describe 'when signed in' do
    it 'is posts_path when clicked on timeline' do
      visit root_path
      expect(page).to have_content 'Sign in'

      fill_in 'Email', with: 'tea@st.com'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
      using_wait_time 2 do
        click_on 'Timeline'
        expect(page.current_path).to eq(posts_path)
      end
    end
  end
end
