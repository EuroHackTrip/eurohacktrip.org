class AddCityToStop < ActiveRecord::Migration
  def change
    add_reference :stops, :city, index: true
  end
end
