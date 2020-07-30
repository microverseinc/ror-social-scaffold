module FriendshipsHelper
  def friends
    @user.friends
    # @user.friends + @user.users
  end
end
