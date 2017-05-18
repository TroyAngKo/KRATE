class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @review = ActiveRecord::Base::Review::find(params[:id])
    @movie = Tmdb::TV.detail(@review.movie_id).title
    @user = User::find(@review.user_id)
  end


  # GET /reviews/new
  def new
    @review = Review.new
    
    @movies = Show.order(:title)

    if !params['format'].nil?
      @selected_show = Integer(params['format'])
    end

  end

  # GET /reviews/1/edit
  def edit
    @review = Review.new
    @movies = Tmdb::Keyword.movies(10586).results

    @movies = @movies.sort_by &:title
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new
    @review.movie_id = params[:movie_id]
    @review.user_id = params[:user_id]
    @review.review = review_params[:review]

    if !User.find(params[:user_id]).has_recommended_this(params[:movie_id])
      @review.recommend = review_params[:recommend]
    end

    if !User.find(params[:user_id]).has_rated_this(params[:movie_id])
      @review.rating = params[:rating]
    end

    respond_to do |format|
      if @review.save
        format.html { redirect_to show_path(@review.movie_id), notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:movie_id, :user_id, :rating, :review, :recommend)
    end
end
