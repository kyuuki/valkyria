class ApplicationController < ActionController::Base
  before_action :set_site

  # サイト設定
  def set_site
    @site = Site.find_by(host: request.host)

    @site = Site.find(1) if @site.nil?
  end
end
