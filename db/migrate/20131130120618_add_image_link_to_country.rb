class AddImageLinkToCountry < ActiveRecord::Migration
  def change
    add_column :countries, :image_link, :string
  end
end
