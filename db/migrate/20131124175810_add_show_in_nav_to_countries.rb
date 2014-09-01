class AddShowInNavToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :show_in_nav, :boolean
  end
end
