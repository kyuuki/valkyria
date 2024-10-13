class StaticPageController < ApplicationController
  def home
    @is_home = true
  end

  def about
    render "#{@site.template}/static_page/about"
  end

  def team
  end

  def testimonials
  end

  def services
  end

  def portfolio
  end

  def portfolio_details
    render layout: "application_base"
  end

  def pricing
  end

  def blog
  end

  def blog_single
  end

  def contact
    render "#{@site.template}/static_page/contact"
  end
end
