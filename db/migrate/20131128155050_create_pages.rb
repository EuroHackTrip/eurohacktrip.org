class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.text :body
      t.boolean :show_in_nav

      t.timestamps
    end
  end
end
