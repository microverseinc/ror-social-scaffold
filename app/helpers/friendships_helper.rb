module FriendshipsHelper
  def pending_sent_requests
    return unless @sent_requests

    "#{@sent_requests.count} Pending Sent Requests"
  end

  def pending_incoming_requests
    return unless @incoming_requests

    "#{@incoming_requests.count} Pending Incoming Requests"
  end

  def first_friendship_button(other_user)
    if current_user.sent_invite?(other_user)
      button_tag 'Invite Sent', type: 'button', disabled: true, class: 'btn btn-secondary'
    elsif current_user.incoming_invite?(other_user)
      button_to 'Accept Friend',
                { action: 'update', controller: 'friendships',
                  id: current_user.incoming_invite?(other_user).id },
                method: :put, type: 'button', class: 'btn btn-secondary'
    elsif current_user.friendship_with?(other_user)
      button_tag 'You\'re Friends', type: 'hidden', disabled: true, class: 'btn btn-secondary'
    elsif current_user == other_user
      button_tag 'You', type: 'hidden', disabled: true, class: 'btn btn-secondary'
    else
      button_to 'Invite Friend',
                { action: 'create', controller: 'friendships', friend_id: other_user.id },
                method: :post, type: 'button', class: 'btn btn-secondary'
    end
  end

  def second_friendship_button(other_user)
    if current_user.sent_invite?(other_user)
      button_to 'Cancel Invite',
                { action: 'destroy', controller: 'friendships',
                  id: current_user.sent_invite?(other_user).id },
                method: :delete, data: { confirm: 'Are you sure?' },
                type: 'button', class: 'btn btn-secondary'
    elsif current_user.incoming_invite?(other_user)
      button_to 'Reject Friend',
                { action: 'destroy', controller: 'friendships',
                  id: current_user.incoming_invite?(other_user).id },
                method: :delete, data: { confirm: 'Are you sure?' },
                type: 'button', class: 'btn btn-secondary'
    elsif current_user.friendship_with?(other_user)
      button_to 'Remove Friend',
                { action: 'destroy', controller: 'friendships',
                  id: current_user.friendship_with?(other_user).id },
                method: :delete, data: { confirm: 'Are you sure?' },
                type: 'button', class: 'btn btn-secondary'
    end
  end
end
