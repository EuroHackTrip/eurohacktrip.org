class PostsController < ApplicationController
  #impressionist :actions=>[:show,:index]
  # before_action :load_posts
  # load_and_authorize_resource
  before_action :set_post, only: [:update, :destroy]
  before_action :authenticate_user!, except: [:show, :index, :post_by_author]
  impressionist :unique => [:impressionable_type, :impressionable_id, :session_hash]

  # GET /posts
  # GET /posts.json
  def index
    if PostSetting.all.count > 0
      @posts = Post.order("created_at desc").paginate(:page => params[:page], :per_page => PostSetting.last.posts_per_page)
    else
      @posts = Post.order("created_at desc").paginate(:page => params[:page], :per_page => 10)
    end
    if params[:tag]
      @posts = @posts.tagged_with(params[:tag])
    else
      @posts = @posts.all
    end
  end

  # def load_posts
  #   @all_posts = Post.new(post_params)
  # end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.friendly.find(params[:id])
    if request.path != post_path(@post)
      redirect_to @post
    end
    impressionist(@post)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    set_post
    if current_user.is_admin || @post.user_id == current_user.id
      @post = Post.friendly.find(params[:id])
    else
      redirect_to dashboard_index_path, alert: 'You don\'t have permission to do that.'
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    # authorize! :create, @post
    @post.user_id = current_user.id
    if current_user.is_admin
      @post.published = true
    else
      @post.published = false
    end
    respond_to do |format|
      if @post.save
        format.html { redirect_to dashboard_index_path, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_path, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_index_path }
      format.json { head :no_content }
    end
  end

  def publish
    if current_user.is_admin
      @post = Post.friendly.find(params[:id])
      @post.published = !@post.published
      @post.save!
      redirect_to dashboard_index_path
    else
      redirect_to dashboard_index_path, alert: 'You don\'t have permission to do that.'
    end
  end

  def post_by_author
    nick_names.each do |author|
      if author.split("=>")[0] == request.fullpath.split("/")[1]
        author_id = author.split("=>")[1]
        @posts = Post.where(user_id: author_id)
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :published, :tag_list, :user_id)
    end
end
