require_relative '../rails_helper'

RSpec.describe 'Webpage workflow', type: :system do
  describe 'Navigate the webpage' do
    it 'creates posts' do
      User.create(name: 'Legolas', email: 'legolas@hotmail.com', password: 'thelord')
      visit user_session_path
      fill_in 'Email', with: 'legolas@hotmail.com'
      fill_in 'Password', with: 'thelord'
      click_on 'Log in'
      sleep(3)
      fill_in 'post[content]', with: 'Test post'
      click_on 'Save'
      sleep(3)
    end
  end
end
