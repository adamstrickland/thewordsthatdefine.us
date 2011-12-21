require 'rubygems'
require 'sinatra'
require 'haml'
require 'mongoid'

require File.join(File.dirname(__FILE__), '..', 'app.rb')

require 'rack/test'
require 'rspec'


RSpec.configure do |config|

  config.include Rack::Test::Methods

  def app
    TheWordsThatDefineUs
  end
end