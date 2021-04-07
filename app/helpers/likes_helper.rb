module LikesHelper

def num_of_likes(post)
    likes = Like.where(post_id: post).length
    return likes
end

end