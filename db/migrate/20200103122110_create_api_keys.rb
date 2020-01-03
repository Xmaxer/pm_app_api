class CreateApiKeys < ActiveRecord::Migration[6.0]
  def change
    create_table :api_keys do |t|
      t.string :api_key
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
    add_index :api_keys, :api_key, unique: true
  end
end
