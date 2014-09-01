class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commenter
      t.string :email
      t.string :website
      t.text :content
      t.boolean :approved
      t.references :post, index: true

      t.timestamps
    end
  end
end
