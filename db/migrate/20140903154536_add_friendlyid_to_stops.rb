class AddFriendlyidToStops < ActiveRecord::Migration
  def change
    add_column :stops, :slug, :string
    add_index :stops, :slug, unique: true
  end
end
