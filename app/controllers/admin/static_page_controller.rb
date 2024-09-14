class Admin::StaticPageController < Admin::ApplicationController
  def root
    # render :root  # これが省略されている
  end

  def general_form
    @menu = :general_form
  end

  def validation
    @menu = :validation
  end

  def profile
    @menu = :profile
  end

  def login
    @menu = :login
    render layout: "admin_login"
  end
end
