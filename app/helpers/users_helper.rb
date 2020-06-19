module UsersHelper

    def check_user(user)
        (current_user!=user)
    end 

    def check_profile(user)
    
        (current_user!=user && !current_user.friend?(user)) 
    end

    
end