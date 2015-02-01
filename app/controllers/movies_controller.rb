require 'file_ops'

class MoviesController < ApplicationController
  
  layout "main"

  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js


  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
    authorize! :index, @movies
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    authorize! :show, @movie
    @movie = Movie.find(params[:id]) 
    #@review = Review.new(:movie_id => @movie.id, :user_id => session[:userid])
    if Review.where(movie_id: @movie.id, user_id: session[:userid]).present?
      @review = Review.where(movie_id: @movie.id, user_id: session[:userid]).first
      
    else
      @review = Review.create(movie_id: @movie.id, user_id: session[:userid])
    end
    @rounded_stars = Review.where(movie_id: @movie.id).where("stars > 0").size > 0 ? Review.where(movie_id: @movie.id).where("stars > 0").average(:stars) : 0
    @user_name = User.find(@review.user_id).nickname
    @last_user_review = User.find(@movie.reviews.last.user_id) unless @movie.reviews.last.nil?
    @track_times = TrackTimes.where({movie_id: @movie.id, user_id: session[:userid]})
    unless @track_times.size == 0
      @track_times.first.update(review_view_time: Time.now)
    else
      TrackTimes.new(movie_id: @movie.id, user_id: session[:userid], review_view_time: Time.now).save
    end
  end

  def set_view_options
    
  end

  # GET /movies/new
  def new
    authorize! :index, @movie
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    find_movie_by_url
    @movie = Movie.new(movie_params)
    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    find_movie_by_url
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:user_id, :title, :orig_title, :year, :link, :image)
    end

    def find_movie_by_url
      #if params[:url_upload_button] && !params[:url_upload_textbox].empty?
      unless params[:url_upload_textbox].empty?
        @file_ops = FileOps.new()
        params[:movie][:image] = @file_ops.get_image_from_url(params[:url_upload_textbox])
        @image_link = params[:movie][:image]
      end  
    end
end
