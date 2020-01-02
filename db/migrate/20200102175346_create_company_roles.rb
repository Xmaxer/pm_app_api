class CreateCompanyRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :company_roles do |t|
      t.string :name
      t.string :colour
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end

    add_index :company_roles, :name, unique: true, name: "unique_role_name_index"
  end
end
