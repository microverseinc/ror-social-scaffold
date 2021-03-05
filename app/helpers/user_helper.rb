module UserHelper
    def invitation_link(user)
        if current_user.pending_invitation?(user)
            link_to "Pending"
        else
            if current_user.friends_with?(user)
                "Connected"
            else
                button_to "Invite", invitation_path(receiver: user)
            end
        end
    end
end
