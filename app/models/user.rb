# class User < ApplicationRecord
#   # Include default devise modules. Others available are:
#   # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
#   devise :database_authenticatable, :registerable,
#          :recoverable, :rememberable, :validatable

#   validates :name, presence: true, length: { maximum: 20 }

#   has_many :posts
#   has_many :comments, dependent: :destroy
#   has_many :likes, dependent: :destroy
# end

class User < ActiveRecord::Base
  has_many :friendies
  has_many :inverse_friendies, :class_name => "Friendie", :foreign_key => "friend_id"

  def friends
    friends_array = friendies.map{|friendie| friendie.friend if friendie.confirmed}
    friends_array + inverse_friendies.map{|friendie| friendie.user if friendie.confirmed}
    friends_array.compact
  end
end
