class AddExtraColumnsToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :country, :string
    add_column :admins, :interest, :text
    add_column :admins, :funding_profile, :string
    add_column :admins, :video_link, :string
    add_column :admins, :approved, :boolean
  end
end
