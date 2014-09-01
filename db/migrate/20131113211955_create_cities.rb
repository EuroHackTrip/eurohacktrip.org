class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.references :country, index: true
      t.text :description
      t.timestamps
    end
  end
end
