class AddEventVenueToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_venue, :string
  end
end
