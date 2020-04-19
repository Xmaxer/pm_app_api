class CreateApiKeyHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :api_key_histories do |t|
      t.references :api_key, null: false, foreign_key: true
      t.string :query

      t.timestamps
    end
  end
end
