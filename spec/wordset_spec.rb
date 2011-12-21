require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../models/wordset'

describe Wordset do
	before :each do
		@myword = "Foo"
		@mywords_arr = [@myword, "Bar"]
		@mywords_str = @mywords_arr.join(", ")
		@ctx = "Some context"
		@ownr = "The owner"
	end

	describe "when initializing" do
		it "should require at least one word" do
			Wordset.new(@myword).words.should have(1).items
		end

		it "should accept a context" do
			Wordset.new(@myword, context: @ctx).words.first.context.should_not be_nil
		end

		it "should accept an owner" do
			Wordset.new(@myword, owner: @ownr).words.first.owner.should_not be_nil
		end

		it "should accept both an owner and a context" do
			ws = Wordset.new(@myword, owner: @ownr, context: @ctx)
			ws.words.first.owner.should_not be_nil
			ws.words.first.context.should_not be_nil
		end

		describe "when dealing with multiple words" do
			before :each do
				@ws = Wordset.new(@mywords_arr, owner: @ownr, context: @ctx)
			end

			it "should handle multiple comma-delimited words in array" do
				@ws.words.should have(@mywords_arr.size).items
			end

			it "should handle multiple comma-delimited words in str" do
				Wordset.new(@mywords_str).words.should have(@mywords_arr.size).items
			end

			it "should copy the context to every word" do
				@ws.words.map{|w| w.context == @ctx}.should be_all
			end

			it "should copy the owner to every word" do
				@ws.words.map{|w| w.owner == @ownr}.should be_all
			end

			it "should copy the owner and the context to every word" do
				@ws.words.map{|w| w.owner == @ownr && w.context == @ctx}.should be_all
			end
		end
	end

	describe "when saving" do
		it "should persist the word" do
			Wordset.new(@myword).save.should be_true
		end

		it "should persist all the words" do
			Wordset.new(@mywords_arr).save.should be_true
		end
	end
end