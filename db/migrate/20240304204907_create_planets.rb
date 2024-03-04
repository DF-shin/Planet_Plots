class CreatePlanets < ActiveRecord::Migration[7.1]
  def change
    create_table :planets do |t|
      t.string :name
      t.string :img
      t.string :description

      t.timestamps
    end
  end
end
