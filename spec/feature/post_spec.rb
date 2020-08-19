require 'rails_helper'

RSpec.describe Post, type: :feature do
  def log_in(user)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
  end

  describe 'creating a post' do
    let(:user) { User.create(email: 'jtt44j@gmweweail.com', name: 'juxoe', password: 'joiu43run3jdws') }
    let(:content) { 'life is beautiful' }

    it 'creates a post' do
      log_in(user)
      fill_in 'post_content', with: content
      click_on 'Save'
      expect(page).to have_content 'life is beautiful'
    end
  end
end
