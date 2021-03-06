class Show < ActiveRecord::Base
	has_many :reviews, foreign_key: :movie_id
	def rating
		rating = Review.where(movie_id: self.id).where('rating is not null').average(:rating)

		if !rating.nil?
			return rating.round(2)
		else
			return 'No ratings yet'
		end
	end
end
