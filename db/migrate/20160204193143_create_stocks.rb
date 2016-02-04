class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :name, null: false
    end
  end
end
