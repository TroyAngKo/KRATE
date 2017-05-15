class StartupController < ApplicationController
  def index
  	@movie = Tmdb::Movie.detail(550)
  end

end
