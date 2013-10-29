class Tweet < ActiveRecord::Base
  belongs_to :user

  has_many :retweets

  validates :content, :presence => true, :length => { :minimum => 2, :maximum => 140 }
  validates :user, :presence => true

  # Gets all tweets made by the users referenced by the ids passed, starting with the
  # most recent tweet made.
  #
  def self.by_user_ids(*ids)
    [:flatten!, :compact!, :uniq!].each{ |meth| ids.send(meth) }
    where(
      arel_table[:user_id]
      .in(ids)
      .or(arel_table[:id].in(
        Retweet.where(:user_id => ids).map(&:tweet_id)
      ))
    ).order('created_at DESC')
  end
end
