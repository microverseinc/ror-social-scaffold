module FriendrequestsHelper
  def link_to_friends
    render 'layouts/friends_list' if current_user
  end
end
