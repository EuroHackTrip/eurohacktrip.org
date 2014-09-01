class AddFriendlyidToPartner < ActiveRecord::Migration
  def change
    add_column :partners, :slug, :string
  end
end
