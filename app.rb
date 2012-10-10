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
require 'omniauth-google-oauth2'
require 'omniauth-github'
require 'omniauth-linkedin'
require 'omniauth-foursquare'

class ThatTimeWhen < Sinatra::Base
	use Rack::Session::Cookie,
		:key => 'identity',
		:expire_after => 2592000, # In seconds
		:secret => ENV['COOKIE_SECRET']
	## Authentication set up
	use OmniAuth::Builder do
		provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
		provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
		provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET']
		provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
		provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKED_SECRET']
		provider :foursquare, ENV['FOURSQUARE_KEY'], ENV['FOURSQUARE_SECRET']
	end

	# Deal with Authentication completion
	%w(get post).each do |method|
		send(method, "/auth/:provider/callback") do
			ap = AuthPlatform.find_or_initialize_by_provider_and_uid(env['omniauth.auth'].provider,env['omniauth.auth'].uid)

			if ap.new_record?
				if session[:user].is_a? User
					session[:user].auth_platforms << ap
				else
					session[:user] = User.new
					session[:user].auth_platforms << ap

					session[:user].display_name = env['omniauth.auth']['info']['nickname'] || env['omniauth.auth']['info']['first_name']
				end
				ap.save
			else
				session[:user] = ap.user || User.new
				session[:user].auth_platforms << ap if session[:user].new_record?
			end

			session[:user].email ||= env['omniauth.auth']['info']['email']
			session[:user].save
			redirect "/"
		end
	end

	get '/logout' do
		session.clear
		redirect '/'
	end

	# Landing page: Show a story, log in, sign up, write a story
	get '/' do
		@story = Story.current

		@platforms = {
			:facebook => {
				:letter => 'f',
				:description => 'Facebook'
			},
			:twitter => {
				:letter => 'l',
				:description => 'Twitter'
			},
			:github => {
				:letter => 'g',
				:description => 'Github'
			}
		}

		(session[:user].auth_platforms rescue []).each do |ap|
			begin
				@platforms[ap.provider.to_sym][:linked] = true
			rescue
			end
		end

		@identified = session[:user].is_a?(User)

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