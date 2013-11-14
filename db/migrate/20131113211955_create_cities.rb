class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.text :description
      t.references :country, index: true

      t.timestamps
    end
  end
end
