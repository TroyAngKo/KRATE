class Review < ActiveRecord::Base
	belongs_to :user
	def reviewer
		User::find(self.user_id).username
	end
end
