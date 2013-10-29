class Tweet < ActiveRecord::Base
  belongs_to :user

  validates :content, :presence => true, :length => { :minimum => 2, :maximum => 140 }
  validates :user, :presence => true

  # Gets all tweets made by the users referenced by the ids passed, starting with the
  # most recent tweet made.
  #
  def self.by_user_ids(*ids)
    where(:user_id => ids.flatten.compact.uniq).order('created_at DESC')
  end
end
