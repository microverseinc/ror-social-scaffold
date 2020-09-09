require_relative './authentication_helper'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.extend AuthenticationHelper, type: :controller
end
