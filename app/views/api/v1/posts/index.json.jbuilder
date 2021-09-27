
json.posts @posts do |post|
  json.id post.id

  json.post_author post.user.name
  json.content post.content
  json.created_at post.created_at


  json.comments post.comments do |comment|
    json.id comment.id
    json.comment_author comment.user.name
    json.content comment.content
    json.created_at comment.created_at
  end
end