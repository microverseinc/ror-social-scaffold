require 'rails_helper'

RSpec.describe 'Model', type: :model do 
  describe Friendship do
    describe 'Associations' do
      it { should belong_to(:invitor).class_name('User') }
      it { should belong_to(:invitee).class_name('User') }
    end
  end
end