module UserHelper
    def make_friend_request
      #TODO: Check if the request is already sent
        content_tag(:button,
                    class: 'w3-button w3-blue') do
          unless current_user.id == params[:id].to_i
            (link_to 'send friend request', "/users/#{params[:id]}/request", method: :post, 
              data:{ confrim: 'Send a friend request?' })
          end
        end
    end

    def pending_requests_header
      content_tag(:h1) { 'Pending Friends' unless current_user.id != params[:id].to_i }
    end
  
    def pending_requests
      pending_requests = current_user.pending_requests
      content_tag(:ul, :class => 'a class') do
        pending_requests.each do |pending_request|
         concat content_tag(:li,  "Name: #{pending_request.name} 
             Email: #{pending_request.email}")
        end
      end
    end
end