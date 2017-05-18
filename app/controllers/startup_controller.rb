# encoding: utf-8
class StartupController < ApplicationController
  require 'open-uri'
  require 'json'

  def index
   #  @movies = Tmdb::Keyword.movies(10586).results
  	# @a = Tmdb::Discover.tv.results
    
    @movies = Show.all

    # first 4 popular shows
    @trending = @movies.order(:popularity).where('backdrop_path != ?', "")[0..3]
    
    # first 12 highest votes shows
    @featured = @movies.order(:vote_average)[0..11]
    
    # first 12 newest shows
    @new = @movies.order(:release_date)[0..11]

  end

  def about_us

  end

  def discover
    @shows = Show.all.paginate(:page => params[:page], :per_page => 20)
  end

  def community

  end

  def delete_reviews
    Review.delete_all
    redirect_to :back
  end

  def delete_users
    User.delete_all
    redirect_to :back
  end

  def get_background

    @movie = Tmdb::TV.detail(params[:movie_id].to_i)
    title = {"movie_title" => @movie.poster_path}
    respond_to do |format|
      format.html
      format.json { render json: title }  # respond with the created JSON object
    end
  end

  def get_username
    @user = User::where(username: params[:username]).count
    puts @user
    reply = {"found" => @user}
    respond_to do |format|
      format.html
      format.json { render json: reply }  # respond with the created JSON object
    end
  end

  def get_email
    @user = User::where(email: params[:email]).count
    puts @user
    reply = {"found" => @user}
    respond_to do |format|
      format.html
      format.json { render json: reply }  # respond with the created JSON object
    end
  end
end
