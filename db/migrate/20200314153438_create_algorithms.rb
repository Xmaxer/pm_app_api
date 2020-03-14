class CreateAlgorithms < ActiveRecord::Migration[6.0]
  def change
    create_table :algorithms do |t|
      t.references :asset, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
