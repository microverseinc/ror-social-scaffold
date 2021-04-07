require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Associations' do
    it { should have_many(:received_invitations) }
    it { should have_many(:sent_invitations) }
  end
end
