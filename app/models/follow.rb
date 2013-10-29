class Follow < ActiveRecord::Base
  # The 'following' association refers to a User object.
  # ref: http://guides.rubyonrails.org/association_basics.html#options-for-belongs-to-class-name
  #
  belongs_to :following, :class_name => "User"
  belongs_to :user

  validates :following, :presence => true
  validates :user, :presence => true
end
