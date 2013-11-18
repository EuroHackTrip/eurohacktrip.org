class AddAvatarToCountry < ActiveRecord::Migration
  def change
    add_column :countries, :avatar, :string
  end
end
