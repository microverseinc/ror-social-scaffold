module FriendshipsHelper
  def friends
    @user.friends
  end

  def add_friend(user)
    return unless signed_in? && !Friendship.reacted?(current_user.id, user.id) && current_user != user

    link_to 'Add Friend', friendships_create_path(ids: { id1: current_user.id, id2: user.id }),
            class: 'friend btn btn-success btn-sm'
  end

  def cancel_request(user)
    cancel = ''
    return unless signed_in? && !Friendship.confirmed_record?(current_user.id, user.id) && current_user != user

    user.pending_friendships.each do |friendship|
      if current_user
        cancel = link_to 'Cancel Request', friendships_destroy_path(friendship_id: friendship.id),
                         class: 'btn btn-danger btn-sm'
      end
    end
    cancel.html_safe
  end

  def reject_response(user)
    reject = ''
    if signed_in? &&
       !Friendship.confirmed_record?(current_user.id, user.id) && current_user == user
      user.pending_friendships.each do |friendship|
        if current_user
          reject = link_to 'Reject',
                           friendships_destroy_path(friendship_id: friendship.id), class: 'btn btn-danger btn-sm'
        end
      end
      reject.html_safe
    end
  end

  def accept_response(user)
    accept = ''
    if signed_in? &&
       !Friendship.confirmed_record?(current_user.id, user.id) && current_user == user
      user.pending_friendships.each do |friendship|
        next unless current_user

        accept = link_to 'Accept',
                         friendships_update_path(friendship_id: friendship.id),
                         class: 'btn btn-success btn-sm'
      end
      accept.html_safe
    end
  end

  def display_name(user)
    name = ''
    if signed_in? &&
       !Friendship.confirmed_record?(current_user.id, user.id) &&
       current_user == user
      user.pending_friendships.each do |friendship|
        name = User.find(friendship.user_id).name if current_user
      end
      name.html_safe
    end
  end

  def unfriend(friend)
    un_friend = ''
    if @user == current_user
      un_friend = link_to 'Un-friend',
                          friendships_destroy_path(friendship_id: Friendship.find_request(@user.id, friend.id)),
                          class: 'btn btn-danger btn-sm'
    end
    un_friend.html_safe
  end

  def link_add_friend(user)
    add_friend(user) if Friendship.where(user_id: current_user.id)
  end

  def link_cancel_request(user)
    cancel_request(user) if Friendship.where(user_id: current_user.id)
  end
end
