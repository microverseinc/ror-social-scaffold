
module UserHelper
	def invert_pending_friendship(id)
		@invers_pending.find_by(user_id: id)
	end

	def pending_friendship(id)
		@pending.find_by(friend_id: id)
	end

	def friends(id)
		true if @confirmed_friendship.find_by(friend_id: id) or @invert_confirmed_friendship.find_by(user_id: id)
	end

	def notFriends(id)
		true if current_user.friendships.find_by(friend_id:id) or current_user.inverse_friendships.find_by(user_id: id) 
	end
end
