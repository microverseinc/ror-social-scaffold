require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before(:each) do
    @user = create(:user)
    @user_two = create(:user, email: 'carl@carl', password: 'carlbond', name: 'Carl')
  end
end