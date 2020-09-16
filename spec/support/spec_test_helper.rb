module SpecTestHelper
    def login(username)

            before(:each) do
              @request.env["devise.mapping"] = Devise.mappings[:user]
              user = FactoryGirl.create(:user)
              #user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
              sign_in user
            end

    end
  
    def current_user
      User.find(request.session[:user_id])
    end
end
