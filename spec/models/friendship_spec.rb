require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'Asociation' do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name(:User) }
  end
end
