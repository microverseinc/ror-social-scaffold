module SentInvitesHelper
  def sent_invites(sent_invites)
    out = ''
    sent_invites.each do |friendship|
      next if current_user.confirmed_friend?(friendship.friend)

      out += ' <span class="profile-link">'
      out += link_to friendship.friend.name, user_path(friendship.user), class: 'profile-link'
      out += '</span><br>'
    end
    out.html_safe
  end
end
