class User < ActiveRecord::Base
	has_many :stories
	has_many :auth_platforms
	has_many :likes

	def avatar
		'http://www.gravatar.com/avatar/'+Digest::MD5.hexdigest(email)
	end
end

class Story < ActiveRecord::Base
	belongs_to :user
	has_many :likes

	def self.current(include_flagged = false)
		where = include_flagged ? {} : {:flagged => 0}
		story_id = (((Time.now - Time.at(487696500))/(60*60*24)).floor % self.where(where).count) + 1
		find(story_id)
	rescue
		nil
	end
end

class AuthPlatform < ActiveRecord::Base
	belongs_to :user
end

class Like < ActiveRecord::Base
	belongs_to :story
	belongs_to :user
end