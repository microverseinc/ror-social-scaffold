require 'rails_helper'

RSpec.describe User, type: :model do

  before{ @user = FactoryGirl.build(:user) }

  context "when name is blank" do 
    it {expect(@user).to be_valid }
   end

 it { expect(@user).to respond_to(:name)}
 it { expect(@user).to respond_to(:email)}
 it { expect(@user).to respond_to(:password)}

 end
