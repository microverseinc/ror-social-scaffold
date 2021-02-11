module Features
  module SessionsHelper
    def feature_sign_in(user = nil)
      user ||= create(:user)
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end
  end
end
