class AddCodeToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :code, :string, null: false
  end
end
