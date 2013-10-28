require 'spec_helper'

describe Tweet do
  context "associations" do
    it { should belong_to :user }
    it { should have_many :retweets }
  end

  context "factories" do
    describe "#tweet" do
      subject { FactoryGirl.build(:tweet) }

      it { should be_valid }
    end
  end

  context "validations" do
    it { should validate_presence_of :content }
    it "should not be valid when the length is between 2 and 140 characters" do
      t1 = Tweet.new(:content => '1')
      t2 = Tweet.new(:content => ':)')
      t3 = Tweet.new(:content => 'fdsjklsjfksdk fd kslfsdjkd')
      t4 = Tweet.new(:content => '*'*140)
      t5 = Tweet.new(:content => '#'*141)

      [t1, t5].each do |t|
        t.valid?
        t.errors[:content].should be_present
      end

      [t2, t3, t4].each do |t|
        t.valid?
        t.errors[:content].should_not be_present
      end
    end

    it { should validate_presence_of :user }
  end

  describe ".by_user_ids" do
    let!(:t1) { FactoryGirl.create(:tweet) }
    let!(:t2) { FactoryGirl.create(:tweet) }
    let!(:t3) { FactoryGirl.create(:tweet) }
    let!(:t4) { FactoryGirl.create(:tweet) }
    let!(:t5) { FactoryGirl.create(:tweet) }
    let!(:t6) { FactoryGirl.create(:tweet) }

    it "should search by user ids" do
      Tweet.by_user_ids(t1.user.id, t3.user.id).load.map(&:id).should == [t3.id, t1.id]
    end

    it "should include retweets of the users" do
      t4.retweets.create!(:user => t3.user)
      t5.retweets.create!(:user => t4.user)
      t6.retweets.create!(:user => t2.user)

      Tweet.by_user_ids(t1.user.id, t3.user.id).load.map(&:id).should == [t4.id, t3.id, t1.id]
    end
  end
end
