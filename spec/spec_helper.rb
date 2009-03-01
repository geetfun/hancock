require 'rubygems'
require 'pp'
require 'spec'
require 'sinatra/test'
require 'dm-sweatshop'

$:.push File.join(File.dirname(__FILE__), '..', 'lib')
require 'hancock'
#gem 'webrat', '~>0.4.2'
#require 'webrat/sinatra'
#require 'webrat/selenium'

require File.expand_path(File.dirname(__FILE__) + '/fixtures')
DataMapper.setup(:default, 'sqlite3::memory:')
DataMapper.auto_migrate!

#Webrat.configure do |config|
#  config.mode = :sinatra
#  config.application_port = 4567
#  config.application_framework = :sinatra
#  if ENV['SELENIUM'].nil?
#    config.mode = :sinatra
#  else
#    config.mode = :selenium
#  end
#end

Hancock::App.set :environment, :test

Spec::Runner.configure do |config|
  def app
    @app ||= Hancock::App.tap do |app| 
      app.set :environment, :test
      app.disable :run, :reload
    end
  end
  config.include(Sinatra::Test)
#  config.include(Webrat::Methods)
#  config.include(Webrat::Matchers)

  config.before(:each) do
    Hancock::App.set :environment, :test
  end
end
