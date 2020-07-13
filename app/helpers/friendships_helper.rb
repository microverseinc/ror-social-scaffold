module FriendshipsHelper
  def request_sent?(user_id)
    @sent = Friendship.where('(sender_id = ? and receiver_id = ?) OR (receiver_id = ? and sender_id = ?)',
                             current_user.id, user_id, current_user.id, user_id)
    return @sent[0].status if @sent.length.positive?

    'rejected'
  end

  def sender_information(user_id)
    User.find_by(id: user_id)
  end

  def timeline_posts
    arr = []
    associated_posts = []
    @friends = Friendship.where('(sender_id = ? and status = ?) OR (receiver_id = ? and status = ?)',
                                current_user.id, 'accepted', current_user.id, 'accepted')
    @friends.each do |friend|
      if friend.sender_id == current_user.id
        arr.push(friend.receiver_id)
      else
        arr.push(friend.sender_id)
      end
    end
    arr.push(current_user.id)

    posts = Post.all

    posts.each do |post|
      associated_posts.push(post) if arr.include?(post.user_id)
    end

    associated_posts.reverse
  end

  def pending_requests
    Friendship.where('receiver_id = ? and status = ?', current_user.id, 'pending').count
  end
end
