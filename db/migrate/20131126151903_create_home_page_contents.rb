class CreateHomePageContents < ActiveRecord::Migration
  def change
    create_table :home_page_contents do |t|
      t.text :content

      t.timestamps
    end
  end
end
