class CreateShotResults < ActiveRecord::Migration
  def change
    create_table :shot_results do |t|
      t.integer :player_id
      t.integer :hole_id
      t.integer :shot_num
      t.integer :pat_num

      t.timestamps
    end
  end
end
