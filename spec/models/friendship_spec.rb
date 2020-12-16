require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'association' do
    it { should belong_to(:requesting_user).class_name('User') }

    it { should belong_to(:receiving_user).class_name('User') }
  end
end
