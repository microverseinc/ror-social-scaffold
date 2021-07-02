module UserHelper
    def display_links(user)
        link = ''
        if current_user == user
        link = content_tag :span, "Current user", class: "bg-yellow"
      elsif current_user.pending?(user)
        link = content_tag :span, "Pending...", class: "bg-orange"
      elsif current_user.requested?(user)
         link << link_to("Accept", confirm_friendship_path(id: user.id), method: :put, class: "btn-green")
         link << link_to("Decline", friendship_path(id: user.id), method: :delete, data: {confirm: "Are you sure you want to decline friend request?"}, class: "btn-red")
      elsif current_user.friend?(user)
        link << link_to('Remove Friendship',  friendship_path(id: user.id), method: :delete, data: {confirm: "Are you sure you want to remove friend?"}, class: "btn-red")
      elsif !current_user.friend?(user)
         link <<link_to('Invite to friendship',  friendships_path(user_id: user.id), method: :post, action: :confirm, class: 'btn-green') 
      end 
      link.html_safe
    end

  end