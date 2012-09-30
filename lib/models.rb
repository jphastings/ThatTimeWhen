class User < ActiveRecord::Base

end

class Story < ActiveRecord::Base
	def self.current(include_flagged = false)
		where = include_flagged ? {} : {:flagged => 0}
		story_id = (((Time.now - Time.at(487696500))/(60*60*24)).floor % self.where(where).count) + 1
		find(story_id)
	end
end