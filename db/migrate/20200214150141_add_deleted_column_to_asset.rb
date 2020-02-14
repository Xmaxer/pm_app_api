class AddDeletedColumnToAsset < ActiveRecord::Migration[6.0]
  def change
    add_column :assets, :deleted, :boolean, default: false, null: false
  end
end
