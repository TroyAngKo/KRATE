# encoding: utf-8
class StartupController < ApplicationController
  require 'open-uri'
  require 'json'

  def index
   #  @movies = Tmdb::Keyword.movies(10586).results
  	# @a = Tmdb::Discover.tv.results

    response = open('https://api.themoviedb.org/3/discover/movie?api_key=401b1b1c2360ebe7559fdd9c1328359f&sort_by=original_title.asc&include_adult=false&include_video=false&page=1&with_keywords=10586').read
    data = JSON.parse(response)
    @movies = data['results']

    # first 4 popular shows
    @trending = @movies.sort_by{|show| -show['popularity']}[0..3]
    
    # first 12 highest votes shows
    @featured = @movies.sort_by{|show| -show['vote_average']}[0..11]
    
    # first 12 newest shows
    @new = @movies.sort_by{|show| show['release_date']}[0..11]

  end

  def about_us

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

    @movie = Tmdb::Movie.detail(params[:movie_id].to_i)
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
