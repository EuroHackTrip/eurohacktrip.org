class RemoveImageLinkFromCountry < ActiveRecord::Migration
  def change
  	remove_column :countries, :image_link
  end
end
