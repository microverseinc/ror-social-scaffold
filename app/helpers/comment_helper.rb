module CommentHelper
def comment_creation_time(comment)
  comment.created_at.strftime("%Y/%m/%d")
end
end