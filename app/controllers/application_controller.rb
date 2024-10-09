class ApplicationController < ActionController::Base
  before_action :set_site

  # https://railsguides.jp/layouts_and_rendering.html#%E5%AE%9F%E8%A1%8C%E6%99%82%E3%81%AB%E3%83%AC%E3%82%A4%E3%82%A2%E3%82%A6%E3%83%88%E3%82%92%E6%8C%87%E5%AE%9A%E3%81%99%E3%82%8B
  layout :sites_layout

  # サイト設定
  def set_site
    @site = Site.find_by(host: request.host)

    @site = Site.first if @site.nil?
  end

  private
    def sites_layout
      @site.template
    end
end
