class CreateDolls < ActiveRecord::Migration
  def change
    create_table :dolls do |t|
      t.integer :user_id
      t.integer :doll_id
      t.integer :position
      t.integer :hp, :default => 7
      t.integer :maxhp, :default => 7
      t.integer :lv, :default => 1
      t.integer :exp, :default => 0
      t.integer :str, :default => 1
      t.string :job, :default => 'fig'

      t.timestamps
    end
  end
end
