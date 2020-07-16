module LoginHelper
  def do_login(email, password)
    visit root_path
    fill_in('user_email', with: email)
    fill_in('user_password', with: password)
    click_button('commit')
  end

  def send_invitation(email, password)
    do_login(email, password)

    click_link('All users')
    click_link('invite to friendship')
  end
end
