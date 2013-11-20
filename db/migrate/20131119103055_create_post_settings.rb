class CreatePostSettings < ActiveRecord::Migration
  def change
    create_table :post_settings do |t|
      t.integer :posts_per_page
      t.boolean :allow_comments

      t.timestamps
    end
  end
end
