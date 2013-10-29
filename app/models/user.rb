class User < ActiveRecord::Base
  # see: https://github.com/plataformatec/devise
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :follows
  has_many :tweets

  validates :name, :presence => true
  validates :username, :presence => true, :uniqueness => true

  # Scope method to get all users except the one passed.
  #
  def self.all_except(user)
    User.where(arel_table[:id].not_eq(user.id)).order(:name)
  end

  # Leverages Tweet.by_user_ids to return all tweets created by this user
  # and all users that this user follows.
  #
  def all_tweets
    Tweet.by_user_ids(id, *follows.map(&:following_id))
  end
end
