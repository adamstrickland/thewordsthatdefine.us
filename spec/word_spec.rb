require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../models/word'

describe Word do
	before :each do
		@myword = "Foo"
	end

	describe "when initializing" do
		before :each do
			@ctx = "Some text"
			@ownr = "The owner"
		end

		describe "a word" do
			# it "should be required" do
			# end

			it "should be accepted" do
				Word.new(name: @myword).name.should == @myword
			end
		end

		it "should accept a context" do
			Word.new(name: @myword, context: @ctx).context.should == @ctx
		end

		it "should accept an owner" do
			Word.new(name: @myword, owner: @ownr).owner.should == @ownr
		end

		it "should accept both a context and an owner" do
			w = Word.new(name: @myword, context: @ctx, owner: @ownr)
			w.context.should == @ctx
			w.owner.should == @ownr
		end

		it "should automatically generate a timestamp" do
			Word.new(name: @myword).created_at.should_not be_nil
		end
	end

	describe "when saving" do
		it "should persist" do
			Word.new(name: @myword).save.should be_true
		end
	end
end