class CreateNewDolls < ActiveRecord::Migration
  def change
    create_table :new_dolls do |t|
      t.integer :town_id
      t.integer :seed

      t.timestamps
    end
  end
end
