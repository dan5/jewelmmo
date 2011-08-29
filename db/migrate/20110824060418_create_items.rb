class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :user_id
      t.integer :doll_id
      t.integer :event_id
      t.string :name

      t.timestamps
    end
  end
end
