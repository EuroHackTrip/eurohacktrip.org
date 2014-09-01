class AddFriendlyidToStartup < ActiveRecord::Migration
  def change
    add_column :startups, :slug, :string
  end
end
