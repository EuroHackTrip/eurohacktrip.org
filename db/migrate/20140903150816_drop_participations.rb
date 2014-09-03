class DropParticipations < ActiveRecord::Migration
  def change
  	drop_table :participations
  end
end
