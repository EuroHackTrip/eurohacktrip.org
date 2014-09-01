class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.references :startup, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
