class CreatePlots < ActiveRecord::Migration[7.1]
  def change
    create_table :plots do |t|
      t.string :name
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.references :planet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
