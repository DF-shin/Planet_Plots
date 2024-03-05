class AddPriceToPlots < ActiveRecord::Migration[7.1]
  def change
    add_column :plots, :price, :float
  end
end
