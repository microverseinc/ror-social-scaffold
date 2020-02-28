module Integration
  def visit_page_and_fill_in_form
    visit new_user_registration_path
    within('form') do
      fill_in 'Name', with: 'john'
      fill_in 'Email', with: 'john@gmail.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
    end
  end

  def sign_up_sign_out
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
    click_link 'Sign out'
  end

  def create_initial_conditions
    visit new_user_registration_path
    within('form') do
      fill_in 'Name', with: 'john'
      fill_in 'Email', with: 'john@gmail.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
    end
    click_button 'Sign up'
    click_link 'Timeline'
  end

  def create_posts
    fill_in 'post_content', with: 'First Post'
    click_button 'Save'
    fill_in 'post_content', with: 'Second Post'
    click_button 'Save'
  end
end
