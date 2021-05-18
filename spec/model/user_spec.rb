require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: 'user', email: 'user@example.com', password: '987654321') }
  let(:inv_user) { User.create(name: '', email: 'user@example.com', password: '987654321') }
  let(:friendships) { User.reflect_on_association(:friendships).macro }
  let(:inverse_friendships) { User.reflect_on_association(:inverse_friendships).macro }
  let(:posts) { User.reflect_on_association(:posts).macro }
  let(:likes) { User.reflect_on_association(:likes).macro }
  let(:comments) { User.reflect_on_association(:comments).macro }
 
  it 'checks user validity' do
    @user = User.create(name: 'user', email: 'user@example.com', password: '987654321')
    expect(@user).to be_valid
  end

end

