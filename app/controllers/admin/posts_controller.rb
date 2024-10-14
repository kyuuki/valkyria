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
    # サムネイル
    postmeta = @post.postmetum.where(meta_key: "thubmnail").first
    if postmeta.nil?
      @thumbnail = ""
    else
      @thumbnail = postmeta.meta_value
    end
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    # サムネイル
    unless params["thumbnail"].blank?
      @post.postmetum.new(meta_key: "thubmnail", meta_value: params["thumbnail"])
    end

    if @post.save
      redirect_to edit_admin_post_url(@post), notice: "登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    # サムネイル
    if params["thumbnail"].blank?
      @post.postmetum.find_by(meta_key: "thubmnail")&.destroy
    else
      pm = @post.postmetum.find_by(meta_key: "thubmnail")
      pm = @post.postmetum.build(meta_key: "thubmnail") if pm.nil?

      pm.meta_value = params["thumbnail"]
      pm.save!  # 本当はトランザクション
    end

    if @post.update(post_params)
      redirect_to edit_admin_post_url(@post), notice: "更新しました。"
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
