class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :follows
  has_many :retweets
  has_many :tweets

  validates :name, :presence => true
  validates :username, :presence => true, :uniqueness => true

  def self.all_except(user)
    User.where(arel_table[:id].not_eq(user.id)).order(:name)
  end

  def all_tweets
    Tweet.by_user_ids(id, *follows.map(&:following_id))
  end
end
