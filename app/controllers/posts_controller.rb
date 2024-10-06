class PostsController < ApplicationController
  # https://railsguides.jp/layouts_and_rendering.html#%E5%AE%9F%E8%A1%8C%E6%99%82%E3%81%AB%E3%83%AC%E3%82%A4%E3%82%A2%E3%82%A6%E3%83%88%E3%82%92%E6%8C%87%E5%AE%9A%E3%81%99%E3%82%8B
  layout :sites_layout

  def index
    @posts = @site.posts.order(posted_at: :desc).page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end
end
