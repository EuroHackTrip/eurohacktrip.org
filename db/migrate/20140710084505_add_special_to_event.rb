class AddSpecialToEvent < ActiveRecord::Migration
  def change
    add_column :events, :special, :boolean
  end
end
