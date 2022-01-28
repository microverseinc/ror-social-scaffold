describe 'the signin process', type: :feature do
  before :each do
    User.create(email: 'mary@now.com', password: 'chris414', name: 'Mary')
  end

  it 'signs me in' do
    visit new_user_session_path
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'

    click_button 'Log in'
    expect(page).to_not have_content 'Signed in successfully.'
  end

  it 'signs me in' do
    visit new_user_session_path
    fill_in 'Email', with: 'mary@now.com'
    fill_in 'Password', with: 'chris414'

    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end

  it 'signs me out' do
    visit destroy_user_session_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  it 'signs me out' do
    visit new_user_session_path
    expect(page).to_not have_content 'You need to sign in or sign up before continuing.'
  end
end
