module FriendshipsHelper
  def friendship_id(user)
    iterating_through_array(user) unless @friendships.nil?
  end

  def iterating_through_array(user)
    ids_array = @friendships.pluck(:id, :friend_id, :user_id)
    ids_array.each do |sub_array|
      return Friendship.find(sub_array[0]).id if sub_array[1] == current_user.id && sub_array[2] == user.id
    end
  end

  def pending_friends
    @pending_friends.compact.each { |friend| concat(card(friend)) }&.nil?
  end

  def card(friend)
    content_tag :div, class: 'card w-25 mx-auto mb-4' do
      concat(content_tag(:h5, "Added you #{friend.created_at}", class: 'card-header'))
      concat(card_body(friend))
    end
  end

  def card_body(friend)
    content_tag :div, class: 'card-body' do
      concat(content_tag(:h5, friend.name, class: 'card-title'))
      concat(content_tag(:span, (link_to 'Confirm', user_path(friend.id),
                                         method: 'post', class: 'btn btn-primary mr-3')))
      concat(content_tag(:span, (link_to 'Decline', user_friendship_path(current_user.id, friendship_id(friend)),
                                         method: :delete, class: 'btn btn-danger')))
    end
  end
end
