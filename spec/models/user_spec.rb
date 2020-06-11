require 'rails_helper.rb'

describe User, type: :model do
  context 'creates new user' do
    it 'Creates a new valid user' do
      u = User.new(name: 'user1', email: 'user1@mail.com', \
                   password: '123456', password_confirmation: '123456')
      u.save
      expect(u.persisted?).to eql(true)
    end

    it 'fails if name not present' do
      u = User.new(email: 'user1@mail.com')
      u.save
      expect(u.persisted?).to eql(false)
    end

    it 'fails if name length > 20' do
      u = User.new(name: '123456789012345678901', email: 'user1@mail.com')
      u.save
      expect(u.persisted?).to eql(false)
    end
  end

  context 'User log in Log out' do
    it 'User should be able to login the app' do
      user1 = User.new(name: 'user1', email: 'user1@mail.com', \
                       password: '123456', password_confirmation: '123456')
      user1.save
      visit('/users/sign_in')
      fill_in 'user_email', with: 'user1@mail.com'
      fill_in 'user_password', with: '123456'
      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully'
    end
  end
end
