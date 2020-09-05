require_relative './authentication_helper' # or require_relative './controller_macros' if write in `spec/support/devise.rb`

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, :type => :controller
  config.extend AuthenticationHelper, :type => :controller
end