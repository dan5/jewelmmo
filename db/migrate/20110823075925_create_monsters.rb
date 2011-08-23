class CreateMonsters < ActiveRecord::Migration
  def change
    create_table :monsters do |t|
      t.integer :event_id
      t.string :name
      t.integer :hp

      t.timestamps
    end
  end
end
