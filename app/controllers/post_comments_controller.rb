class PostCommentsController < ApplicationController
  layout "post_comment"
  before_filter :modify_content, :only => [:create, :update]
  #before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    authorize! :index, @post_comments
    @comments = PostComment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    authorize! :show, @post_comments
    @comments = PostComment.where({post_id: params[:post_id]})
    @post = Post.where({id: params[:post_id]}).first
    @comment = PostComment.new(:post_id => @post.id, :user_id => session[:userid])

    @track_times = PostTrackTimes.where({post_id: @post.id, user_id: session[:userid]})
    unless @track_times.size == 0
      @last_login = @track_times.first.updated_at
      @track_times.first.update(view_time: Time.now)
    else
      PostTrackTimes.new(post_id: @post.id, user_id: session[:userid], view_time: Time.now).save
    end
  end

  # GET /comments/new
  def new
    authorize! :new, @post_comment
    @post_comment = PostComment.new
  end

  # GET /comments/1/edit
  def edit
    authorize! :edit, @post_comments
  end

  # POST /comments
  # POST /comments.json
  def create
    @post_comment = PostComment.new(comment_params)

    respond_to do |format|
      if @post_comment.save
        format.html { redirect_to post_comments_path(params[:post_id]), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @post_comment }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @post_comment.update(comment_params)
        format.html { redirect_to @post_comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @post_comment }
      else
        format.html { render :edit }
        format.json { render json: @post_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @post_comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @post_comment = PostComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:post_comment).permit(:post_id, :parent_id, :user_id, :content)
    end

    def modify_content
      params[:post_comment][:content] = params[:post_comment][:content].gsub(/(\r)?\n/, '<br />').gsub('<img', '<br /><img').gsub('/img>', '/img><br />') unless params[:post_comment][:content].nil?
    end
end
