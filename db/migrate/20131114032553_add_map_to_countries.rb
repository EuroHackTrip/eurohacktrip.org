class AddMapToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :map, :string
  end
end
