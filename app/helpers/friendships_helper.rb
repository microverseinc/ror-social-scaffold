module FriendshipsHelper

  def friendships_collection
    friendships = Friendship.where(user_id: current_user.id, confirmed: true)
    friendships += Friendship.where(friend_id: current_user.id, confirmed: true)
    friendships.compact
  end

  def current_friends(user)
     friend_arr = []
     friendships_collection.each do |relation|
       if relation.user_id == user.id 
          element = User.find_by(id: relation.friend_id)
          friend_arr << element
       else 
          element2 = User.find_by(id: relation.user_id)
          friend_arr << element2
       end
     end
   end

  def user_friends(user)
     friend_arr = []
     friendships_collection.each do |relation|
       if relation.user_id == user.id 
          element = User.find_by(id: relation.friend_id)
          friend_arr << element
       else 
          element2 = User.find_by(id: relation.user_id)
          friend_arr << element2
       end
     end
  end

  def mutual_friend(user1, user2)
      c_f = current_friends(user1)
      u_f = user_friends(user2)
     mutual_arr = c_f & u_f
     return mutual_num = mutual_arr.count
  end


end
