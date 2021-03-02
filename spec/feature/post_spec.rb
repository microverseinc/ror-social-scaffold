require_relative '../rails_helper.rb'

RSpec.describe 'post functionality', type: :system do
  describe 'posting' do
    it 'should post' do
      user = User.find_by(email: 'tea@st.com')
      User.create!(email: 'tea@st.com', password: '1256', password_confirmation: '1256', name: 'ss') if user.nil?
      visit root_path
      fill_in 'Email', with: 'tea@st.com'
      fill_in 'Password', with: '1256'
      click_on 'Log in'
      find('#post_content').set('I posted')
      click_on 'Save'
      expect(User.find_by(email: 'tea@st.com').posts[0].content).to eq('I posted')
      expect(page).to have_content('I posted')
    end
  end
end
