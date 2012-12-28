class CreateUserAttributes < ActiveRecord::Migration
  def change
    create_table :user_attributes do |t|
      t.string :key
      t.string :value
      t.references :user

      t.timestamps
    end
    add_index :user_attributes, :user_id
    add_index :user_attributes, [:user_id, :key], unique: true
  end
end
