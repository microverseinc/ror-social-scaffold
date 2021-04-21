class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github, :googl_oauth2]

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, foreign_key: :inviter_id
  has_many :invitees, through: :friendships

  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :invitee_id
  has_many :inviters, through: :inverse_friendships

  has_many :comfirmed_friendships, -> { where status: true }, class_name: 'Friendship', foreign_key: :inviter_id
  has_many :friends, through: :comfirmed_friendships, source: :invitee

  def friends_and_own_posts
    Post.where(user_id: [*friends, self])
  end

  def friend_requests
    Friendship.where(invitee_id: self, status: false)
  end

  def pending_requests
    Friendship.where(inviter_id: self, status: false)
  end
end
