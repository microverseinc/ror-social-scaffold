describe 'Create a post', type: :feature do
  before :each do
    @user = User.create(email: 'user@example.com', password: 'password', name: 'user')
    visit '/users/sign_in'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end
  after :each do
    @user.destroy
  end

  it 'Create a post' do
    fill_in 'post_content', with: 'Content of the post'

    click_button 'Save'
    expect(page).to have_content 'Post was successfully created.'
  end
end
