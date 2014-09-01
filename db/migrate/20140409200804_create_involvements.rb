class CreateInvolvements < ActiveRecord::Migration
  def change
    create_table :involvements do |t|
      t.references :startup, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
