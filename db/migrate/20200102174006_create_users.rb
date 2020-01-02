class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.string :email
      t.string :phone_number
      t.string :secret_key
      t.boolean :enabled

      t.timestamps
    end

    add_index :users, :email, unique: true, name: "unique_email_index"
    add_index :users, :phone_number, unique: true, name: "unique_phone_number_index"
  end
end
