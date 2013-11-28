class RemoveSlugFromCountries < ActiveRecord::Migration
  def change
  	remove_column :countries, :slug
  end
end
