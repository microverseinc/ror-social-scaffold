describe 'Sign in', type: :feature do
  before :each do
    @user = User.create(email: 'user@example.com', password: 'password', name: 'user')
  end
  after :each do
    @user.destroy
  end

  it 'sign in user' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')
  end
  it "doesn't sign in unregistered user" do
    visit '/users/sign_in'
    fill_in 'Email', with: 'wrong_user@example.com'
    fill_in 'Password', with: 'wrong_password'
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end
end
