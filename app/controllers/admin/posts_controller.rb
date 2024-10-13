class Admin::PostsController < Admin::ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :set_menu

  # GET /posts
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result.order(posted_at: :desc).page(params[:page]).per(30)
  end

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.posted_at = Time.zone.now.change(hour: 0, min: 0, sec: 0)
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to admin_posts_url, notice: "登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to admin_posts_url, notice: "更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_url, notice: "削除しました。"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :posted_at, :status, site_ids: [], tag_ids: [])
    end

    def set_menu
      @menu = :posts
    end
end
