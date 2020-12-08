class Friendship < ApplicationRecord
  belongs_to :sender, class_name: :Friendship
  belongs_to :receiver, class_name: :Friendship
end
