class CreateWorlds < ActiveRecord::Migration
  def change
    create_table :worlds do |t|
      t.integer :turn, :default => 0

      t.timestamps
    end
  end
end
