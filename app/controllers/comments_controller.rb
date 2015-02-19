class CommentsController < ApplicationController
  layout "comment"
  before_filter :modify_content, :only => [:create, :update]
  #before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    authorize! :index, @comments
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    authorize! :show, @comments
    @comments = Comment.get_comments_for_movie(params[:movie_id])
    @movie = Movie.where({id: params[:movie_id]}).first
    @comment = Comment.new(movie_id: @movie.id, user_id: session[:userid])
    @last_user_review = User.get_review_last_view_time(@movie)
    @track_times = TrackTimes.where({movie_id: @movie.id, user_id: session[:userid]})
    unless @track_times.size == 0
      @last_login = @track_times.first.updated_at
      @track_times.first.update(comment_view_time: Time.now)
    else
      TrackTimes.new(movie_id: @movie.id, user_id: session[:userid], comment_view_time: Time.now).save
    end
  end

  # GET /comments/new
  def new
    authorize! :new, @comment
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    authorize! :edit, @comments
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to comments_path(params[:movie_id]), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:movie_id, :parent_id, :user_id, :content)
    end

    def modify_content
      params[:comment][:content] = params[:comment][:content].gsub(/(\r)?\n/, '<br />').gsub('<img', '<br /><img').gsub('/img>', '/img><br />') unless params[:comment][:content].nil?
    end
end
