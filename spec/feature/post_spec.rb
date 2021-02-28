require_relative '../rails_helper.rb'

RSpec.describe 'post functionality', type: :system do
  describe 'posting' do
    it 'should post' do
      user = User.find_by(email: 'tea@st.com')
      User.create!(email: 'tea@st.com', password: '123456', password_confirmation: '123456', name: 'ss') if user.nil?
      visit root_path
      fill_in 'Email', with: 'tea@st.com'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
      find('#post_content').set('I posted')
      click_on 'Save'
      expect(User.find_by(email: 'tea@st.com').posts[0].content).to eq('I posted')
      expect(page).to have_content('I posted')
    end
    it 'should not post when content is blank' do
      visit root_path
      fill_in 'Email', with: 'tea@st.com'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
      click_on 'Save'
      expect(page).to have_content('Post could not be saved. Content can\'t be blank')
    end
  end
end
