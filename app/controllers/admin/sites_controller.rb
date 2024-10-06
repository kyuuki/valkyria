class Admin::SitesController < Admin::ApplicationController
  before_action :set_site, only: %i[ show edit update destroy ]
  before_action :set_menu

  # GET /sites
  def index
    @menu = :sites
    @sites = Site.all.order(id: :desc)
  end

  # GET /sites/1
  def show
  end

  # GET /sites/new
  def new
    @site = Site.new
  end

  # GET /sites/1/edit
  def edit
  end

  # SITE /sites
  def create
    @site = Site.new(site_params)

    if @site.save
      redirect_to admin_sites_url, notice: "登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sites/1
  def update
    if @site.update(site_params)
      redirect_to admin_sites_url, notice: "更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /sites/1
  def destroy
    @site.destroy
    redirect_to sites_url, notice: "削除しました。"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def site_params
      params.require(:site).permit(:host, :name, :template)
    end

    def set_menu
      @menu = :sites
    end
end
