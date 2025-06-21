class Admin::ApplicationController < ActionController::Base
  # ApplicationController は継承しない (完全に切り離す)
  layout "admin"

  before_action :check_host

  # 特定のホスト名でしかアクセスできないように
  def check_host
    unless (request.host == ENV["ADMIN_HOSTNAME"])
      raise ActionController::BadRequest
    end
  end
end
