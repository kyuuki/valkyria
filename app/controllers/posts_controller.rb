class PostsController < ApplicationController
  # https://railsguides.jp/layouts_and_rendering.html#%E5%AE%9F%E8%A1%8C%E6%99%82%E3%81%AB%E3%83%AC%E3%82%A4%E3%82%A2%E3%82%A6%E3%83%88%E3%82%92%E6%8C%87%E5%AE%9A%E3%81%99%E3%82%8B
  layout :sites_layout

  def index
    @is_home = true
    #@posts = @site.posts.order(posted_at: :desc).page(params[:page])
    @posts = @site.posts.includes(:postmetum).order(posted_at: :desc).page(params[:page])
    # ↑これでも meta_key が "thubnail" のものをとってくるときに毎回検索てしまう
    # TODO: あとで効率化は実験しよう

    render "#{@site.template}/posts/index"
  end

  def tags
    @posts = @site.posts.includes(:tags).where(tags: { id: params[:tag_id] }).order(posted_at: :desc).page(params[:page])
    render "#{@site.template}/posts/index"
  end

  #
  # ブログ記事表示
  #
  def show
    @post = @site.posts.find(params[:id])
    render "#{@site.template}/posts/show"
  end
end
