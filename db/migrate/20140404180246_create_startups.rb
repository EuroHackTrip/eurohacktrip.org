class CreateStartups < ActiveRecord::Migration
  def change
    create_table :startups do |t|
      t.string :name
      t.string :logo
      t.string :city
      t.string :tagline
      t.text :description

      t.timestamps
    end
  end
end
