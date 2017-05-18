class UsersController < ApplicationController

	def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
	def profile
		@reviews = Review.where('reviews.review is not null').joins(:user).joins(:show)[0..3]
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
