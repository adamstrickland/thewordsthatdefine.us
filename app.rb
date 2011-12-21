require 'sinatra'
require 'sinatra/base'
require 'sass'
require 'mongoid'
require './partials'

Dir["./models/**/*.rb"].each { |model| require model }

class TheWordsThatDefineUs < Sinatra::Base
	set :erb, :format => :html5

	helpers Sinatra::Partials
    helpers do
      # def yield_content_for(key)
      #   yield_content key
      # end
    end 
    
    Mongoid.configure do |config|
    	if ENV['MONGOHQ_URL'] 
    		conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
    		uri = URI.parse(ENV['MONGOHQ_URL'])
    		config.master = conn.db(uri.path.gsub(/^\//, ''))
    	else
    		config.master = Mongo::Connection.from_uri("mongodb://localhost:27017").db('test')
    	end
    end

	get '/' do
		@words = []
		erb :index
	end

	get '/application.css' do
	  scss :application
	end
end