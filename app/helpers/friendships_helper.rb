module FriendshipsHelper
  def friendship_params
    # requester_id = current_user.id
    params.permit(:confirmer_id, :requester_id)
  end

  def pending_friendships(f, i)
    content_tag(:ul) do
      f.each do |x|
          if x.confirmed == false            
            # concat(
              content_tag(:li) do                
                  content_tag(:div, :class => 'btn-div') do
                    x.requester.name.concat(render partial: 'confirm_decline')
                  end
            end
            # )
          end
      end
    end
  end

end
