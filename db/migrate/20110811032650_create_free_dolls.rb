class CreateFreeDolls < ActiveRecord::Migration
  def change
    create_table :free_dolls do |t|
      t.integer :town_id
      t.integer :seed

      t.timestamps
    end
  end
end
