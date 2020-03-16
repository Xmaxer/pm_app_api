class CreateAlgorithms < ActiveRecord::Migration[6.0]
  def change
    create_table :algorithms do |t|
      t.references :asset, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :expected_features, null: false

      t.timestamps
    end
  end
end
