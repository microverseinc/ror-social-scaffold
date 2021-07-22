require 'rails_helper'
RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:comments) }
  it { should have_many(:likes) }
  it { should have_many(:friendships) }
  it { should have_many(:inverse_friendships) }
end
