class CreateRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :requests do |t|
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.references :plot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
