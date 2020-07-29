require_relative '../rails_helper'

RSpec.describe 'Webpage workflow', type: :system do
  describe 'Add like' do
    it 'Add like on post' do
      User.create(name: 'Gimli', email: 'gimli@hotmail.com', password: 'thelord')
      visit user_session_path
      fill_in 'Email', with: 'gimli@hotmail.com'
      fill_in 'Password', with: 'thelord'
      click_on 'Log in'
      sleep(3)
      fill_in 'post[content]', with: 'The Lord of the Rings'
      click_on 'Save'
      sleep(5)
      click_on 'Like!'
      sleep(3)
      expect(page).to have_content('You liked a post.')
    end
  end
end
