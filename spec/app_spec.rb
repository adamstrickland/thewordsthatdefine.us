require File.dirname(__FILE__) + '/spec_helper'

describe TheWordsThatDefineUs do
	describe "should respond to route" do
		after :each do
			last_response.status.should == 200
		end

		it "/" do
			get "/"
		end

		it "/application.css" do
			get "/application.css"
		end

		it "/words/new" do
			get "/words/new"
		end

		it "/words/create.json" do
			w = "foo"
			post "/words/create.json", words: w
		end
	end
end