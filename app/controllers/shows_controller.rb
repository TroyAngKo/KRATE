class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :edit, :update, :destroy]

  def get_background
    puts "Hi"
    @movie = Tmdb::TV.detail(params[:id].to_i)
    title = {"movie_title" => @movie.title}
    respond_to do |format|
      format.html
      format.json { render json: title }  # respond with the created JSON object
    end
  end
  # GET /shows
  # GET /shows.json
  def index
    @shows = Show.all
  end

  # GET /shows/1
  # GET /shows/1.json
  def show
    @show = Tmdb::TV.detail(params[:id])
    @cast = Tmdb::TV.cast(params[:id])
    @reviews = Review::where(movie_id: params[:id]).where('review is not null').joins(:user)
    @recommendations = Review::where(movie_id: params[:id]).where('recommend is not null').joins(:user)
    @ratings = Review::where(movie_id: params[:id]).where('rating IS NOT NULL').joins(:user)
    @videos = Tmdb::TV.videos(params[:id])
    @images = Tmdb::TV.backdrops(params[:id])

    @review = Review.new

    @tags = Tmdb::TV.keywords(params[:id])
  end

  # GET /shows/new
  def new
    @show = Show.new
  end

  # GET /shows/1/edit
  def edit
  end

  # POST /shows
  # POST /shows.json
  def create
    @show = Show.new(show_params)

    respond_to do |format|
      if @show.save
        format.html { redirect_to @show, notice: 'Show was successfully created.' }
        format.json { render :show, status: :created, location: @show }
      else
        format.html { render :new }
        format.json { render json: @show.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shows/1
  # PATCH/PUT /shows/1.json
  def update
    respond_to do |format|
      if @show.update(show_params)
        format.html { redirect_to @show, notice: 'Show was successfully updated.' }
        format.json { render :show, status: :ok, location: @show }
      else
        format.html { render :edit }
        format.json { render json: @show.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shows/1
  # DELETE /shows/1.json
  def destroy
    @show.destroy
    respond_to do |format|
      format.html { redirect_to shows_url, notice: 'Show was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_show
      @show = Tmdb::TV.detail(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def show_params
      params.require(:show).permit(:title, :description, :rating, :review)
    end
end
