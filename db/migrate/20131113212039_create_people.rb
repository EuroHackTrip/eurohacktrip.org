class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :online_profile_link
      t.string :photo
      t.string :occupation
      t.references :country, index: true

      t.timestamps
    end
  end
end
