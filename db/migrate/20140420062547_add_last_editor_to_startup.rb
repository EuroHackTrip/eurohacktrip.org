class AddLastEditorToStartup < ActiveRecord::Migration
  def change
    add_reference :startups, :user, index: true
  end
end
