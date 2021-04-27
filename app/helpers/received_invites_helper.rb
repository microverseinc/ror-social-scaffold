module ReceivedInvitesHelper
  def received_invites(received_invites)
    out = ''
    received_invites.each do |friendship|
      next if current_user.confirmed_friend?(friendship.user)

      out += '<div class="confirmations">'
      out += '<span class="profile-link">'
      out += link_to friendship.user.name, user_path(friendship.user), class: 'profile-link'
      out += '</span><div class="friends_buttons">'
      out += render 'posts/invite_confirm', friendship: @blank_friendship, user: friendship.user
      out += render 'posts/invite_reject', friendship: friendship
      out += '</div></div>'
    end
    out.html_safe
  end
end
