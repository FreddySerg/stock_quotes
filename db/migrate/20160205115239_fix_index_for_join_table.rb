class FixIndexForJoinTable < ActiveRecord::Migration
  def change
    remove_index :briefcases_stocks, :briefcase_id
    add_index    :briefcases_stocks, [:briefcase_id, :stock_id], unique: true
  end
end
