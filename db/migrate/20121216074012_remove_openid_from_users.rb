class RemoveOpenidFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :openid
  end

  def down
    change_table :users do |t|
      t.string :openid  
    end
  end
end
