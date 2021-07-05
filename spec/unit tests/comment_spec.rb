require 'rails_helper'
RSpec.describe Comment do
  before :each do
    User.create(name: 'John', email: 'example001@example.com',
                password: 'Secret1', password_confirmation: 'Secret1')
    Post.create(user_id: User.first.id,
                content: "Can't believe how exepensive poatoes have become over the past year!")
  end

  describe 'create' do
    it 'rejects request if content is missing' do
      comment = Comment.new(user_id: User.first.id, post_id: Post.first.id, content: '')
      expect(comment.valid?).to eq(false)
    end
    it 'rejects request if content is longer than 200 characters' do
      comment = Comment.new(user_id: User.first.id, post_id: Post.first.id,
                            content: ' Lorem ipsum dolor sit amet, consectetur adipiscing
                             elit. Maecenas sed lorem ac mi semper ullamcorper vel a dolor.
                              Phasellus feugiat in sapien fringilla scelerisque. Integer velit
                               diam, condimentum eu auctor quis, tempus vitae purus. Cras
                                congue augue urna, eu bibendum odio interdum sit amet. Nunc
                                 hendrerit risus sed quam aliquam, nec laoreet metus bibendum.
                                  Maecenas laoreet interdum enim. Maecenas consequat diam
                                   massa, vel laoreet leo ullamcorper in.


            Ut non quam condimentum, interdum neque interdum, interdum velit. Cras nec justo
             quis mi tincidunt luctus eget iaculis purus. Nulla eu sollicitudin lacus. Aenean
              fermentum faucibus magna, nec bibendum erat suscipit sit amet. Nunc ullamcorper
               vestibulum diam eget viverra. Morbi gravida odio eget dui ornare ornare.
                Phasellus in efficitur sem. Ut vestibulum condimentum lacus eget mattis.
                 Integer interdum consectetur magna, in pharetra mi tristique eu. Morbi enim
                  risus, aliquam ut pretium non, semper quis ligula.

            Suspendisse ac rhoncus est. Sed ut erat vel nunc tempus bibendum eget luctus nibh.
             Nunc id dui vel tortor eleifend feugiat sed eget turpis. Vestibulum ante ipsum
             primis in faucibus orci luctus et ultrices posuere cubilia curae; Lorem ipsum
             dolor sit amet, consectetur adipiscing elit. Nulla facilisi. Sed ac massa sed
             felis euismod sollicitudin. Nullam in diam ac purus finibus molestie. Phasellus
             vel tortor quam. Pellentesque quis feugiat sem, et pellentesque quam. Curabitur
             in ipsum nec elit sagittis elementum. Mauris luctus nibh et leo congue ultricies.
             Sed volutpat augue sed felis mollis, quis mollis felis suscipit. In bibendum
             semper neque eu lobortis. Praesent ac metus eget dui accumsan tristique a non
             velit. Sed accumsan massa sem, et fermentum urna dictum sed. ')
      expect(comment.valid?).to eq(false)
    end
    it 'rejects request if user doesn\'t exist' do
      comment = Comment.new(user_id: 0, post_id: Post.first.id, content: 'Valid content for a comment')
      expect(comment.valid?).to eq(false)
    end
    it 'rejects request if post doesn\'t exist' do
      comment = Comment.new(user_id: User.first.id, post_id: 0, content: 'Valid content for a comment')
      expect(comment.valid?).to eq(false)
    end
    it 'accepts request if all values are correct' do
      comment = Comment.new(user_id: User.first.id, post_id: Post.first.id,
                            content: 'Valid content for a comment')
      expect(comment.valid?).to eq(true)
    end
  end
end
