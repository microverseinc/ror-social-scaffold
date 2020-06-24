require 'spec_helper'


describe Module do
  
  it "has a valid factory" do
		expect(User.new(name:'12345', email:"sd12@asd.we", password: "1234567")).to_be valid
	end
end