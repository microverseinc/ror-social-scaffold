require 'devise'
require 'factory_bot'
module AuthenticationHelper
  def log_in_usr(role, name = nil, email = nil)
    before(:each) do
      request.env['devise.mapping'] = Devise.mappings[role]
      user = create(role, name: name, email: email)
      sign_in user
    end
  end
end
