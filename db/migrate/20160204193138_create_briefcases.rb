class CreateBriefcases < ActiveRecord::Migration
  def change
    create_table :briefcases do |t|
      t.references :user, null: false, index: true
      t.string     :name, null: false

      t.timestamps null: false
    end
  end
end
