class PostSettingsController < ApplicationController
  before_action :set_post_setting, only: [:show, :edit, :update, :destroy]

  # GET /post_settings
  # GET /post_settings.json
  def index
    @post_settings = PostSetting.all
  end

  # GET /post_settings/1
  # GET /post_settings/1.json
  def show
  end

  # GET /post_settings/new
  def new
    @post_setting = PostSetting.new
  end

  # GET /post_settings/1/edit
  def edit
  end

  # POST /post_settings
  # POST /post_settings.json
  def create
    @post_setting = PostSetting.new(post_setting_params)

    respond_to do |format|
      if @post_setting.save
        format.html { redirect_to @post_setting, notice: 'Post setting was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post_setting }
      else
        format.html { render action: 'new' }
        format.json { render json: @post_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /post_settings/1
  # PATCH/PUT /post_settings/1.json
  def update
    respond_to do |format|
      if @post_setting.update(post_setting_params)
        format.html { redirect_to dashboard_index_path, notice: 'Post setting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_settings/1
  # DELETE /post_settings/1.json
  def destroy
    @post_setting.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_index_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_setting
      @post_setting = PostSetting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_setting_params
      params.require(:post_setting).permit(:posts_per_page, :allow_comments)
    end
end
