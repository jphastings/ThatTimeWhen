# encoding: utf-8
require 'sinatra/base'
require File.join(File.dirname(__FILE__), 'environment')
require File.join(File.dirname(__FILE__), 'lib','helpers')
require 'slim'
require 'json'
require 'maruku'
require 'omniauth'
require 'omniauth-twitter'
require 'omniauth-facebook'

class ThatTimeWhen < Sinatra::Base
	use Rack::Session::Cookie
	## Authentication set up
	use OmniAuth::Builder do
		provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
		provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
	end

	# Deal with Authentication completion
	%w(get post).each do |method|
		send(method, "/auth/:provider/callback") do
			p env['omniauth.auth']
			env['omniauth.auth'] # => OmniAuth::AuthHash
		end
	end

	# Landing page: Show a story, log in, sign up, write a story
	get '/' do
		@story = Story.current
		slim :home
	end

	# Gets the current story
	get '/stories' do

	end

	# Publishes a new story
	post '/stories' do

	end

	# Edits a story, you must be the owner
	put '/stories/:story_id' do

	end

	# Deletes a story, you must be the owner
	delete '/stories/:story_id' do

	end

	# Shows a specific story, you must be the owner
	get '/stories/:story_id' do

	end
end