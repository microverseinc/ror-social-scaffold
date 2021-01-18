module UsersHelper
  def timeline
    if current_user == @user or @user.friend?(current_user)
      render 'timeline'
    else
      render inline: "<p class='add-to-see'>Add #{@user.name} to see their posts</p>"
    end
  end
end
