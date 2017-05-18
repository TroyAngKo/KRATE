class Review < ActiveRecord::Base
	belongs_to :user
	belongs_to :show, foreign_key: :movie_id
	def reviewer
		User::find(self.user_id).username
	end
end
