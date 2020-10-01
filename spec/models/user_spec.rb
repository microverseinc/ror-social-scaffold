require 'rails_helper'

# RSpec.describe User, type: :model do
#  let(:user) {build(:User)}

#  context "when name is blank" do 
#   before {user.name =""}
#   it {expect(user).not_to be_valid }
#  end
# end
RSpec.describe User, type: :model do

  before{ @user = FactoryGirl.build(:user) }

 it { expect(@user).to respond_to(:name)}
 it { expect(@user).to respond_to(:email)}
 end
