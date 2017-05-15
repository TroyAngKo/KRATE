# encoding: utf-8
class StartupController < ApplicationController
  def index
  	@movies = Tmdb::Keyword.movies(10586).results
  end

  def about_us

  end
end
