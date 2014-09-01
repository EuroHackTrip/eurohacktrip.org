class AddMapToCities < ActiveRecord::Migration
  def change
    add_column :cities, :map, :string
  end
end
