class CreateCompanyRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :company_roles do |t|
      t.string :name, null: false
      t.string :colour, null: false
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end

    add_index :company_roles, [:name, :company_id], unique: true, name: "unique_role_name_index"
  end
end
