begin
	require 'dotenv'
	Dotenv.load
rescue LoadError
end

require 'active_record'
require 'digest/md5'
 
db = URI.parse(ENV['DATABASE_URL'])

ActiveRecord::Base.establish_connection(
	:adapter    => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
	:host       => db.host,
	:username   => db.user,
	:password   => db.password,
	:database   => db.path[1..-1],
	:encoding   => 'utf8'
)

ActiveRecord::Base.include_root_in_json = false

module ActiveSupport
	# == Active Model JSON Serializer
	module JSON
		def self.encode(value,options = {})
			if options.has_key?(:jsonp)
				method_name = options.delete :jsonp
				#TODO: sanitize
				"#{method_name}(#{Encoding::Encoder.new(options).encode(value)})"
			else
				Encoding::Encoder.new(options).encode(value)
			end
		end
	end
end

require File.join(File.dirname(__FILE__),'lib','models.rb')