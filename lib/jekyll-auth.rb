require 'rubygems'
require 'dotenv'
require 'sinatra-index'
require 'sinatra-google-auth'
require 'rack'
require 'safe_yaml'
require File.dirname(__FILE__) + '/jekyll-auth/version'
require File.dirname(__FILE__) + '/jekyll-auth/config'
require File.dirname(__FILE__) + '/jekyll-auth/auth-site'
require File.dirname(__FILE__) + '/jekyll-auth/jekyll-site'
Dotenv.load

class JekyllAuth
  def self.site
    Rack::Builder.new do
      use JekyllAuth::AuthSite
      run JekyllAuth::JekyllSite
    end
  end
end
