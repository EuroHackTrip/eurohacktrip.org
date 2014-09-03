class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.string :name
      t.text :description
      t.string :year
      t.string :dates
      t.string :link

      t.timestamps
    end
  end
end
