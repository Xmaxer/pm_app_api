class CreateUserCompanyRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_company_roles do |t|
      t.references :company_role, null: true, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end

    add_index :user_company_roles, [:company_role_id, :user_id, :company_id], unique: true, name: "unique_user_company_role_index", where: "company_role_id is not null"
    add_index :user_company_roles, [:user_id, :company_id], unique: true, name: "unique_user_company_index", where: "company_role_id is null"
  end
end
