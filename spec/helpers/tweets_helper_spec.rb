require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the TweetsHelper. For example:
#
# describe TweetsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe TweetsHelper do
  let(:user) { FactoryGirl.create(:user) }

  before do
    helper.instance_eval <<-EOS
      def current_user
        User.find(#{user.id})
      end
    EOS
  end

  describe "#can_retweet" do
    let(:tweet) { FactoryGirl.create(:tweet) }

    context "when the tweet belongs to the user" do
      let(:tweet) { FactoryGirl.create(:tweet, :user => user) }

      it "should return false" do
        helper.can_retweet(tweet).should == false
      end
    end

    context "when the tweet has been retweeted by the user" do
      before { user.retweets.create(:tweet => tweet) }

      it "should return false" do
        helper.can_retweet(tweet).should == false
      end
    end

    context "when the tweet has not been retweeted by nor owned by the user" do
      it "should return true" do
        helper.can_retweet(tweet).should == true
      end
    end
  end
end
