describe 'Create a comment', type: :feature do
  before :each do
    @user = User.create(email: 'user@example.com', password: 'password', name: 'user')
  end
  after :each do
    @user.destroy
  end
  it 'Create a comment' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    fill_in 'post_content', with: 'Content of the post'
    click_button 'Save'
    fill_in 'comment_content', with: 'Comment of the post'
    click_button 'Comment'
    expect(page).to have_content 'Comment was successfully created.'
  end
end
