module UserHelper
  def user_image
    gravatar_image_tag('spam@spam.com'.gsub('spam', 'mdeering'), alt: 'Michael Deering')
  end
end
