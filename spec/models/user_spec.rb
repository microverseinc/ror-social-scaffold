require 'rails_helper'

RSpec.describe User, type: :model do
    it 'Create a data container' do
        user = User.new(email: 'wamg@gmail.com', password: '123456')
        expect(user).to be_a_new(User)

    end
end