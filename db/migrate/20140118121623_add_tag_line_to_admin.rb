class AddTagLineToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :tag_line, :string
  end
end
