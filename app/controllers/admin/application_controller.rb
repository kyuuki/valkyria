class Admin::ApplicationController < ActionController::Base
  # ApplicationController は継承しない (完全に切り離す)
  layout "admin"
end
