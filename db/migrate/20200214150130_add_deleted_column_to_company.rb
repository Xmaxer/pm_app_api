class AddDeletedColumnToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :deleted, :boolean, default: false, null: false
  end
end
