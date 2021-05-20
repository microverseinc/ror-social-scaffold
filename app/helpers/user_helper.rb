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
  
  def header(text)
    content_tag(:h1) { "#{text}" }
  end

  def pending_requests
    pending_requests = current_user.pending_requests
    content_tag(:ul, :class => 'a class') do
      pending_requests.each do |pending_request|
        if pending_request
          concat content_tag(:li,  "Name: #{pending_request.name} 
            Email: #{pending_request.email}")
        end
      end
    end
  end

  def friend_requests
    friend_requests = current_user.friend_requests
    content_tag(:ul, :class => 'a class') do
      friend_requests.each do |sender|
        if sender
          concat content_tag(:li,  "Name: #{sender.name} 
            Email: #{sender.email}")
        end
      end
    end
  end   

  def pending_friends_header
    header('Pending Friends')
  end
  def friend_requests_header
    header('Friend Requests')
  end

  def approve_requests
    friend_requests = current_user.friend_requests
    content_tag(:div, :class => 'a class') do
      friend_requests.each do |sender|
        if sender
          concat (link_to 'approve', "/users/#{current_user.id}/approve/#{sender.id}", method: :put,
            data: { confrim: 'approve request?' })
        end
      end
    end
  end


  def delete_requests
    friend_requests = current_user.friend_requests
    content_tag(:div, :class => 'a class') do
      friend_requests.each do |sender|
        if sender
          concat (link_to 'delete', "/users/#{current_user.id}/reject/#{sender.id}", method: :delete,
            data: { confrim: 'approve request?' })
        end
      end
    end
  end


end