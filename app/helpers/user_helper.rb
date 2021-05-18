module UserHelper
    def make_friend_request
        content_tag(:button,
                    class: 'w3-button w3-blue') do
          unless current_user.id == params[:id].to_i
            (link_to 'send friend request', "/users/#{params[:id]}/request", method: :post, data:
              { confrim: 'Send a friend request?' })
          end
        end
    end
end