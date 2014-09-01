class AddDatesToCity < ActiveRecord::Migration
  def change
  	add_column :cities, :dates, :string
  end
end
