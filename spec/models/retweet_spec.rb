require 'spec_helper'

describe Retweet do
  context "associations" do
    it { should belong_to :tweet }
    it { should belong_to :user }
  end

  context "factories" do
    describe "#retweet" do
      subject { FactoryGirl.build(:retweet) }

      it { should be_valid }
    end
  end

  context "validations" do
    it { should validate_presence_of :tweet }
    it { should validate_presence_of :user }
  end
end
