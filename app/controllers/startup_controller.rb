# encoding: utf-8
class StartupController < ApplicationController
  def index
  	@movies = Tmdb::Keyword.movies(10586).results
  end

  def about_us

  end

  def get_background

    @movie = Tmdb::Movie.detail(params[:movie_id].to_i)
    title = {"movie_title" => @movie.backdrop_path}
    respond_to do |format|
      format.html
      format.json { render json: title }  # respond with the created JSON object
    end
  end
end
