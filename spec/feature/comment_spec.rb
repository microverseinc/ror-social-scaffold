require_relative '../rails_helper'

RSpec.describe 'Webpage workflow', type: :system do
  describe 'Add comments' do
    it 'Add comment to a post' do
      User.create(name: 'Legolas', email: 'legolas@hotmail.com', password: 'thelord')
      Post.create(content: 'The Lord of the Rings', user_id: 1)
      visit user_session_path
      fill_in 'Email', with: 'legolas@hotmail.com'
      fill_in 'Password', with: 'thelord'
      click_on 'Log in'
      sleep(3)
      fill_in 'comment[content]', with: 'Comment Test'
      click_on 'Comment'
      sleep(3)
      expect(page).to have_content('Comment Test')
    end
  end
end
