require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "validations tests" do
    it 'ensures content presence' do
      comment = Comment.new().save
      expect(comment).to eq(false) 
    end
    it 'ensures content lenght to be maximum 200' do
      comment = Comment.new(content:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi molestie lobortis diam, ac luctus massa lacinia non. Curabitur cursus elementum sem, fermentum porta lectus tristique sed. Phasellus vitae bibendum sapien.').save
      expect(comment).to eq(false) 
    end
  end
  
end
