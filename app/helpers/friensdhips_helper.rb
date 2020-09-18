module FriensdhipsHelper
  def accept_reject_friend(friendship)
    return if friendship.confirmed

    link_to('Accept friend request', confirm_path(user_id: friendship.user), method: :patch, style: 'margin-right: 20px', class: 'profile-link') << link_to('Reject friend request', reject_path(user_id: friendship.user), method: :delete, class: 'profile-link')
  end
end
