class Admin::PostsController < Admin::ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :set_menu

  skip_forgery_protection only: :org_save

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
    @thumbnail = @post.thumbnail unless @post.thumbnail.nil?

    # YouTube ID
    @youtube_id = @post.youtube_id unless @post.youtube_id.nil?
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    # サムネイル
    unless params["thumbnail"].blank?
      @post.postmetum.new(meta_key: "thubmnail", meta_value: params["thumbnail"])
    end

    # YouTube ID
    unless params["youtube_id"].blank?
      @post.postmetum.new(meta_key: "youtube_id", meta_value: params["youtube_id"])
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
      pm = @post.find_or_build_postmeta("thubmnail")
      pm.meta_value = params["thumbnail"]
      pm.save!  # 本当はトランザクション
    end

    # YouTube ID
    if params["youtube_id"].blank?
      @post.postmetum.find_by(meta_key: "youtube_id")&.destroy
    else
      pm = @post.find_or_build_postmeta("youtube_id")
      pm.meta_value = params["youtube_id"]
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
    # メタデータも全部削除

    redirect_to admin_posts_url, notice: "削除しました。"
  end

  #
  # Org データを入稿
  #
  def org_new
  end

  def org_save
    properties = OrgUtil.parse_property(params[:content])

    content = params[:content]
    ulid = properties[:ulid]
    post_id = properties[:post_id]
    title = properties[:title]
    site_ids = properties[:site_ids]
    tags = properties[:tags]
    posted_at = properties[:posted_at]
    thumbnail = properties[:thumbnail]
    youtube_id = properties[:youtube_id]

    #
    # Post 特定
    #
    unless ulid.nil?
      # ULID がある場合は ULID ベースに Post を特定 or 新規作成
      @post = Post.find_by(ulid:)
      if @post.nil?
        @post = Post.new(ulid:)
        @post.posted_at = Time.zone.now.change(hour: 0, min: 0, sec: 0)
      end
    else
      @post = Post.find(post_id)
    end
    @post.site_ids = site_ids

    html = Orgmode::Parser.new(content).to_html

    doc = Nokogiri::HTML5.fragment(html)

    #
    # タイトル設定
    #
    unless title.nil?
      # TITLE 属性があればそちらを優先
      @post.title = title
    else
      @post.title = doc.at_css("h3").text
    end

    #
    # タグ設定
    #
    unless tags.nil?
      @post.tags.clear

      tags.each do |tag_name|
        tag = Tag.find_by(name: tag_name)
        if tag.nil?
          tag = Tag.create(name: tag_name, color: "red")
        end

        @post.tags << tag
      end
    end

    @post.posted_at = posted_at unless posted_at.nil?

    doc.at_css("h3").remove
    doc.css("h4").map { |x| x.name = "h3" }

    # \\ → 改行が複数あると上手く変換できないバグがある
    # TODO: 全体的なシステムフローを再検討する必要はありそう。Gem Orgmode は廃止したい
    doc.css("p").each do |p|
      p.traverse do |node|
        next unless node.text? && node.content.include?("\n")

        parts = node.content.split("\n")

        parts.each_with_index do |part, i|
          if i == 0
            node = node.replace(Nokogiri::XML::Text.new(part, doc))
          else
            node = node.add_next_sibling(Nokogiri::XML::Text.new(part, doc))
          end
          unless i == parts.size - 1
            node = node.add_next_sibling(Nokogiri::XML::Node.new("br", doc))
          end
        end
      end
    end

    # このやり方だと </code> と </pre> の間に改行が入る
    doc.css("pre").map { |x|
      lang = x.attr("lang")
      lang = "shell" if lang == "sh"
      x.name = "code"
      x["class"] = "language-#{lang}"
      x.wrap("<pre></pre>")
    }

    @post.content = doc.to_xml

    # <pre> と <code> の間にいろいろ入るのに対処
    @post.content.gsub!(/<pre>\s+<code/, "<pre><code")
    # 汚いけど </code> と </pre> の間に改行が入るのに対処
    @post.content.gsub!(/<\/code>\s+<\/pre>/, "</code></pre>")

    @post.save!

    # TODO: トランザクション
    # サムネイル
    if thumbnail.nil?
      @post.postmetum.find_by(meta_key: "thubmnail")&.destroy
    else
      pm = @post.find_or_build_postmeta("thubmnail")
      pm.meta_value = thumbnail
      pm.save!  # 本当はトランザクション
    end

    # YouTube ID
    if youtube_id.nil?
      @post.postmetum.find_by(meta_key: "youtube_id")&.destroy
    else
      pm = @post.find_or_build_postmeta("youtube_id")
      pm.meta_value = youtube_id
      pm.save!  # 本当はトランザクション
    end
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
