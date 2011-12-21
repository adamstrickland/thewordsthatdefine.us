require 'sinatra'
require 'sass'

set :erb, :format => :html5

get '/' do
	erb :index
end

get '/application.css' do
  # header 'Content-Type' => 'text/css; charset=utf-8'
  scss :application
end