require 'rails_helper'

RSpec.describe User, type: :model do

  before :each do
    @user = User.create(username: 'simon')
    @event1 = @user.posts.create(text: 'post 1')
    @event2 = @user.posts.create(text: 'post 2')
  end

  it 'can be created' do
    expect(User.first).to eq(@user)
  end

  it 'username should be present' do
    assert @user.valid?
  end

end
