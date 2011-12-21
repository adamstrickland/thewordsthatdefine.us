require 'sinatra'
require 'sinatra/base'
require 'sass'
require 'mongoid'
require './partials'

Dir["./models/**/*.rb"].each { |model| require model }

class TheWordsThatDefineUs < Sinatra::Base
	set :erb, format: :html5

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
		@words = Word.all(sort:[[:created_at, :desc]])
		erb :index
	end

	get '/application.css' do
	  scss :application
	end

	get '/words/new' do
		erb :'words/new', layout: :lightbox
	end

	post '/words/create.json' do
		ws = Wordset.new(params[:words], context: params[:context], owner: params[:owner])
		if ws.save
			ws.words.map do |w|
				partial(:'words/word', locals: { word: w })
			end.join('\n')
		else
			404
		end
	end
end