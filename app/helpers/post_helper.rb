module PostHelper
  def friends_and_own_posts
    Post.where(user: (self.friends + self))
  end
end
