class CreateFriendRelations < ActiveRecord::Migration
  def change
    create_table :friend_relations do |t|
      t.integer :user_id
      t.integer :friend_id
      t.integer :state

      t.timestamps
    end
    add_index :friend_relations, :user_id
    add_index :friend_relations, :friend_id
    add_index :friend_relations, [:user_id, :friend_id], unique: true
  end
end
