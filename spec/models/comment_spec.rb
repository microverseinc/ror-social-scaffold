require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "Validation test" do
    it { should validate_presence_of(:content) }
it "description" do
  
end

    # it "must have a user" do
    #  comment = Comment.new(content:'Anything', post_id: 1, user_id: 1).save
    #  expect(comment).to eq(true)
    # end
    
  end
end
