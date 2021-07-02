describe 'Sign out', type: :feature do
  before :each do
    User.create(email: 'user@example.com', password: 'password', name: 'user')
    visit '/users/sign_in'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end
  it 'signs me out' do
    click_link 'Sign out'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
