class PostsController < ApplicationController
  def index
    @is_home = true
    #@posts = @site.posts.order(posted_at: :desc).page(params[:page])
    @posts = @site.posts.includes(:postmetum).order(posted_at: :desc).page(params[:page])
    # ↑これでも meta_key が "thubnail" のものをとってくるときに毎回検索てしまう
    # TODO: あとで効率化は実験しよう

    @recent_posts = @site.posts.includes(:postmetum).order(posted_at: :desc).page(params[:page]).limit(5)

    render "#{@site.template}/posts/index"
  end

  def tags
    @posts = @site.posts.includes(:tags).where(tags: { id: params[:tag_id] }).order(posted_at: :desc).page(params[:page])
    @recent_posts = @site.posts.includes(:postmetum).order(posted_at: :desc).page(params[:page]).limit(5)
    render "#{@site.template}/posts/index"
  end

  #
  # ブログ記事表示
  #
  def show
    @post = @site.posts.find(params[:id])
    @recent_posts = @site.posts.includes(:postmetum).order(posted_at: :desc).page(params[:page]).limit(5)
    render "#{@site.template}/posts/show"
  end
end
