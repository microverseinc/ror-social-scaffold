require 'rails_helper'

RSpec.describe 'User' do
  context 'without name' do
    it 'will not be valid ' do
      expect(User.new(email: 'maryjane@gmail.com', password: 'testpassword', id: 2).valid?).not_to be true
    end
  end
  context 'with name longer than 20 characters' do
    it 'will not be valid ' do
      expect(User.new(name: 'josephburkejosephburke', password: 'password', id: 1).valid?).to be false
    end
  end
end
