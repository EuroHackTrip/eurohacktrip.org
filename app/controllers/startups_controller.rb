class StartupsController < ApplicationController
  before_action :set_startup, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_involved, only: [:edit, :update]

  # GET /startups
  # GET /startups.json
  def index
    @startups = Startup.joins(:users).where(users: { approved: 1}).uniq
  end

  # GET /startups/1
  # GET /startups/1.json
  def show
  end

  # GET /startups/new
  def new
    @startup = Startup.new
  end

  # GET /startups/1/edit
  def edit
  end

  # POST /startups
  # POST /startups.json
  def create

    # render json: params
    # render json: params['participation']
    # render json: ActiveSupport::JSON.decode(params['involvement'])

    if params['participation'].blank?
      redirect_to request.referer, notice: 'Hey, click on the events you will participate!'
    elsif ActiveSupport::JSON.decode(params['involvement']).blank? 
      redirect_to request.referer, notice: 'Hey, you have to add people involved in your startup!'
    else
      
      @startup = Startup.new(startup_params)
      @startup.user_id = current_user.id

      respond_to do |format|
        if @startup.save
            # team =  params['involvement'].split(',')
            team =  ActiveSupport::JSON.decode(params['involvement'])
            team.uniq.each do |co|
              if !co.blank?
                Involvement.create! startup_id:@startup.id, user_id:co 
              end
            end
          Participation.create! startup_id:@startup.id, event_id:params['participation']
          format.html { redirect_to @startup, notice: 'Startup was successfully created.' }
          format.json { render action: 'show', status: :created, location: @startup }
        else
          format.html { render action: 'new' }
          format.json { render json: @startup.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /startups/1
  # PATCH/PUT /startups/1.json
  def update

    # render json: params
    # render json: params['participation']

    if ActiveSupport::JSON.decode(params['involvement']).blank? 
      redirect_to request.referer, notice: 'Hey, you have to add people involved in your startup!'
    else
      @startup.user_id = current_user.id
      respond_to do |format|
        if @startup.update(startup_params)
          @startup.slug = @startup.name.downcase
          @startup.save!
          # team =  params['involvement'].split(',')
          team = ActiveSupport::JSON.decode(params['involvement'])
          Involvement.where(startup_id:@startup.id).delete_all
          team.uniq.each do |co|
            if !co.blank?
              Involvement.create! startup_id:@startup.id, user_id:co 
            end
          end
          # Participation.where(startup_id:@startup.id).delete_all
          # Participation.create! startup_id:@startup.id, event_id:params['participation']
          format.html { redirect_to @startup, notice: 'Startup was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @startup.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /startups/1
  # DELETE /startups/1.json
  def destroy
    @startup.destroy
    respond_to do |format|
      format.html { redirect_to startups_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_startup
      @startup = Startup.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def startup_params
      params.require(:startup).permit(:name, :logo, :city, :tagline, :description)
    end

    def check_involved
      unless involved_in(@startup)
        flash[:error] = "You must be added so that you can edit!" 
        redirect_to @startup
      end
    end

end
