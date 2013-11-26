class AddEventLinkToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_link, :string
  end
end
