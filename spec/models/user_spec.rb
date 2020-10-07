require "rails_helper"

RSpec.describe User, :type => :model do
  context "should create new user" do
    user = User.create!
    user.id = 1
    user.name = 'Ramin'
    user.email = 'example@exampler.com'
    user.password = '123456'
    it "should return user name" do
      expect(user.name).to eq('Ramin')
    end
    it "should return user email" do
      expect(user.email).to eq('example@exampler.com')
    end
    it "should return user id" do
      expect(user.id).to eq(1)
    end
    it "should create new user" do
      expect(user.password).to eq('123456')
    end
  end
end