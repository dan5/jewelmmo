class CreateDolls < ActiveRecord::Migration
  def change
    create_table :dolls do |t|
      t.integer :user_id
      t.integer :hp, :default => 7
      t.integer :lv, :default => 1
      t.integer :exp, :default => 0
      t.integer :str, :default => 1

      t.timestamps
    end
  end
end
