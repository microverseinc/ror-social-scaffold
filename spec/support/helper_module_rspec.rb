module HelperModuleRspec
  def login_user(user)
    visit 'users/sign_in'
    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
    end
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')
  end

  def visit_and_click(user, action)
    visit root_path
    click_link 'All users'
    within 'ul' do
      within('li', text: user.name) do
        click_link action
        sleep(2)
      end
    end
  end
end
