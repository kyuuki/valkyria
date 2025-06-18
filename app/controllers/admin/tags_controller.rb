class Admin::TagsController < Admin::ApplicationController
  before_action :set_tag, only: %i[ show edit update destroy ]
  before_action :set_menu

  # GET /tags
  def index
    @menu = :tags
    @tags = Tag.all.order(id: :desc)
  end

  # GET /tags/1
  def show
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to admin_tags_url, notice: "登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tags/1
  def update
    if @tag.update(tag_params)
      redirect_to admin_tags_url, notice: "更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tags/1
  def destroy
    @tag.destroy
    redirect_to admin_tags_url, notice: "削除しました。"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tag_params
      params.require(:tag).permit(:name, :color)
    end

    def set_menu
      @menu = :tags
    end
end
