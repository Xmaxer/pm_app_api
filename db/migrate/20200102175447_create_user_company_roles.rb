class CreateUserCompanyRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_company_roles do |t|
      t.references :company_role, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :user_company_roles, [:company_role_id, :user_id], unique: true, name: "unique_user_company_role_index"
  end
end
