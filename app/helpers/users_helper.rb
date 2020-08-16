module UsersHelper
  def buttons(user)
    render 'users/buttons', user: user
  end
end
