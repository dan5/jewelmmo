class CreateDungeons < ActiveRecord::Migration
  def change
    create_table :dungeons do |t|
      t.integer :town_id
      t.integer :lv, :default => 1

      t.timestamps
    end
  end
end
