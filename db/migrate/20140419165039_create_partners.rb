class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :name
      t.text :description
      t.string :link
      t.integer :tier
      t.integer :year

      t.timestamps
    end
  end
end
