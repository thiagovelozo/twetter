require 'spec_helper'
require Rails.root + 'lib/mention_linker.rb'

describe MentionLinker do
  let(:linker) { MentionLinker.new(double) }

  describe "#link_mentions" do
    context "when passed text with an @ symbol" do
      context "which is not inside an a element" do
        let(:txt) { 'I like @bluefocus' }
        let(:expected) { 'I like <a href="/bluefocus">@bluefocus</a>' }

        it "should add a link to the user's twets page" do
          linker.link_mentions(txt).should == expected
        end
      end

      context "which is a component of an a larger word" do
        let(:txt) { 'dan@bluefoc.us' }

        it "should not change the text" do
          linker.link_mentions(txt).should == txt
        end
      end
    end
  end
end

