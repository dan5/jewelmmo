class CreateDungeons < ActiveRecord::Migration
  def change
    create_table :dungeons do |t|
      t.integer :town_id
      t.integer :lv

      t.timestamps
    end
  end
end
