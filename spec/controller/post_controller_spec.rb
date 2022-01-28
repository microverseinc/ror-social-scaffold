describe 'the post process', type: :feature do
  before :each do
    User.create(email: 'mary@now.com', password: 'chris414', name: 'Mary')
    Post.create(content: 'Mary has a post')
  end
end
