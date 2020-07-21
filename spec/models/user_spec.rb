require 'rails_helper'

RSpec.describe User, type: :model do
  it 'creates a new user' do
    user = create(:user)
    expect(user).to be_present
  end
end