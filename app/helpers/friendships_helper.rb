module FriendshipsHelper
  def first_friendship_button(other_user)
    if current_user.sent_invite(other_user)
      button_to 'Invite Sent', {}, type: 'hidden', disabled: true, class: 'btn btn-secondary'
    elsif current_user.incoming_invite(other_user)
      button_to 'Accept Friend',
                { action: 'update', controller: 'friendships',
                  id: current_user.incoming_invite(other_user).id },
                method: :put, type: 'button', class: 'btn btn-secondary'
    elsif current_user.friend?(other_user)
      button_to 'You\'re Friends', {},
                type: 'hidden', disabled: true, class: 'btn btn-secondary'
    elsif current_user == other_user
      button_to 'You',
                { action: 'create', controller: 'friendships', friend_id: other_user.id },
                method: :post, type: 'hidden', disabled: true, class: 'btn btn-secondary'
    else
      button_to 'Invite Friend',
                { action: 'create', controller: 'friendships', friend_id: other_user .id },
                method: :post, type: 'button', class: 'btn btn-secondary'
    end
  end

  def second_friendship_button(other_user)
    if current_user.sent_invite(other_user)
      button_to 'Cancel Invite',
                { action: 'destroy', controller: 'friendships',
                  id: current_user.sent_invite(other_user).id },
                method: :delete, data: { confirm: 'Are you sure?' },
                type: 'button', class: 'btn btn-secondary'
    elsif current_user.incoming_invite(other_user)
      button_to 'Reject Friend',
                { action: 'destroy', controller: 'friendships',
                  id: current_user.incoming_invite(other_user).id },
                method: :delete, data: { confirm: 'Are you sure?' },
                type: 'button', class: 'btn btn-secondary'
    elsif current_user.friend?(other_user)
      button_to 'Remove Friend',
                { action: 'destroy', controller: 'friendships',
                  id: current_user.friend?(other_user).id },
                method: :delete, data: { confirm: 'Are you sure?' },
                type: 'button', class: 'btn btn-secondary'
    end
  end
end
