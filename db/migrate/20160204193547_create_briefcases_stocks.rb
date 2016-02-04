class CreateBriefcasesStocks < ActiveRecord::Migration
  def change
    create_table :briefcases_stocks do |t|
      t.references :briefcase, null: false, index: true
      t.references :stock,     null: false, index: true
    end
  end
end
