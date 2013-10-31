require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the TwetsHelper. For example:
#
# describe TwetsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe TwetsHelper do
  let(:user) { FactoryGirl.create(:user) }

  before do
    helper.instance_eval <<-EOS
      def current_user
        User.find(#{user.id})
      end
    EOS
  end

  describe "#can_retwet" do
    let(:twet) { FactoryGirl.create(:twet) }

    context "when the twet belongs to the user" do
      let(:twet) { FactoryGirl.create(:twet, :user => user) }

      it "should return false" do
        helper.can_retwet(twet).should == false
      end
    end

    context "when the twet has been retweted by the user" do
      before { user.retwets.create(:twet => twet) }

      it "should return false" do
        helper.can_retwet(twet).should == false
      end
    end

    context "when the twet has not been retweted by nor owned by the user" do
      it "should return true" do
        helper.can_retwet(twet).should == true
      end
    end
  end
end
