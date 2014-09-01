class AddYearToCity < ActiveRecord::Migration
  def change
  	add_column :cities, :year, :string
  end
end
