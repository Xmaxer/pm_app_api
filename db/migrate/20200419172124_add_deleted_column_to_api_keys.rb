class AddDeletedColumnToApiKeys < ActiveRecord::Migration[6.0]
  def change
    add_column :api_keys, :deleted, :boolean, default: false, null: false
  end
end
