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

  #
  # Org データを入稿
  #
  def org_new
  end

  def org_save
    content = ""
    title = nil
    post_id = nil

    params[:content].each_line do |line|
      if line.match?(/^#\+TITLE:/)
        title = line.gsub(/^#\+TITLE: +/, "")
        next
      end

      if line.match?(/^#\+POST_ID:/)
        post_id = line.gsub(/^#\+POST_ID: +/, "").to_i
        next
      end

      content << line
    end

    @post = Post.find(post_id)
    @post.title = title

    html = Orgmode::Parser.new(content).to_html
    doc = Nokogiri::HTML5.fragment(html)
    doc.at_css("h3").remove
    doc.css("h4").map { |x| x.name = "h3" }

    # このやり方だと </code> と </pre> の間に改行が入る
    doc.css("pre").map { |x|
      lang = x.attr("lang")
      lang = "shell" if lang == "sh"
      x.name = "code"
      x["class"] = "language-#{lang}"
      x.wrap("<pre></pre>")
    }

    @post.content = doc.to_xml

    # 汚いけど </code> と </pre> の間に改行が入るのに対処
    @post.content.gsub!(/<\/code>\n+<\/pre>/, "</code></pre>")

    @post.save
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
