class UsersController < ApplicationController
	def profile

	end

	def review_show
	    review = Review.new

	    review.user_id = current_user.id
	    review.movie_id = Integer(params['format'])
	    review.recommend = true

	    review.save
	    redirect_to :back
	end

	def rate_show 
		review = Review.new
		review.user_id = current_user.id
		review.rating = params['rating']
		review.movie_id = params['movie_id']

		review.save
		redirect_to :back
	end
end
