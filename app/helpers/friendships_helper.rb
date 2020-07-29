module FriendshipsHelper
  def friends
    @user.friends + @user.users
  end
  
  def adding_friend
    signed_in? && !Friendship.reacted?(current_user.id, user.id) && current_user != user
  end
  
end
