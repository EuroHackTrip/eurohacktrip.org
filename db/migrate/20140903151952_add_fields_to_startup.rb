class AddFieldsToStartup < ActiveRecord::Migration
  def change
  	add_column :startups, :category, :string
  	add_column :startups, :year, :string
  end
end
