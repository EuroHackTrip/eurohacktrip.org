class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]
  # load_and_authorize_resource

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.friendly.find(params[:id])
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to dashboard_index_path, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    # render json: params
    respond_to do |format|
      if @event.update(event_params)
        @event.slug = @event.event_name.downcase
        @event.save!
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_index_path }
      format.json { head :no_content }
    end
  end

  def pingeventbrite
    # render nothing: true
    # render text: params[:id]
    
    # begin
    
    require Rails.root.to_s + "/lib/eventbrite/eventbrite.rb"
    e = CityEvent.new(params[:id]).response['event']
    render json: {
      'id' => params[:id],
      'title' => e['title'],
      'venue' => e['venue']['name'],
      'tickets' => e['tickets'][0]['ticket']['quantity_available'].to_s
    }

    # rescue Exception => e
    #     render text: e
    # end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      if current_user.is_admin
        @event = Event.friendly.find(params[:id])
      else
        redirect_to dashboard_index_path, alert: 'You don\'t have permission to do that.'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(
        :event_link, 
        :event_name, 
        :event_venue, 
        :event_id, 
        :city_id,
        :year, 
        :date, 
        :icon, 
        :description, 
        :venue_pic,
        :special
        )
    end
end
