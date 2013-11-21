class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :event_id
      t.references :country, index: true

      t.timestamps
    end
  end
end
