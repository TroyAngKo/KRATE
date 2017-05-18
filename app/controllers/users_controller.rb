class UsersController < ApplicationController

	def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
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
end
