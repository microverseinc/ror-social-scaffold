module Helpers
  def sign_up_with(user)
    visit new_user_registration_path
    fill_in 'user_name', with: user.name
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password
    click_button 'Sign up'
  end
end

RSpec.configure do |config|
  config.include Helpers, type: :feature
end
