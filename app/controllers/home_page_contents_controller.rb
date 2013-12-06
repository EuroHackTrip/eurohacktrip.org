class HomePageContentsController < ApplicationController
  before_action :set_home_page_content, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, except: [:show]
  # load_and_authorize_resource

  # GET /home_page_contents
  # GET /home_page_contents.json
  def index
    @home_page_contents = HomePageContent.all
  end

  # GET /home_page_contents/1
  # GET /home_page_contents/1.json
  def show
  end

  # GET /home_page_contents/new
  def new
    @home_page_content = HomePageContent.new
  end

  # GET /home_page_contents/1/edit
  def edit
  end

  # POST /home_page_contents
  # POST /home_page_contents.json
  def create
    @home_page_content = HomePageContent.new(home_page_content_params)
    # authorize! :create, @home_page_content
    respond_to do |format|
      if @home_page_content.save
        format.html { redirect_to root_path, notice: 'Home page content was successfully created.' }
        format.json { render action: 'show', status: :created, location: @home_page_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @home_page_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /home_page_contents/1
  # PATCH/PUT /home_page_contents/1.json
  def update
    # authorize! :update, @home_page_contents
    respond_to do |format|
      if @home_page_content.update(home_page_content_params)
        format.html { redirect_to root_path, notice: 'Home page content was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @home_page_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /home_page_contents/1
  # DELETE /home_page_contents/1.json
  def destroy
    @home_page_content.destroy
    respond_to do |format|
      format.html { redirect_to dashbard_index_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home_page_content
      @home_page_content = HomePageContent.find(params[:id])
      #impressionist(@home_page_content)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def home_page_content_params
      params.require(:home_page_content).permit(:content)
    end
end
