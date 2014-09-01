class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.string :event_link
      t.string :event_name
      t.string :event_venue
      t.integer :event_id
      t.references :city, index: true
      t.string :year 
      t.string :date 
      t.text :description 
      t.string :icon 

      t.timestamps
    end
  end
end
