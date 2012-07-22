class AddIndexPlayeridAndGolfholeidToShotResults < ActiveRecord::Migration
  def change
    add_index(:shot_results, [:player_id, :golf_hole_id], unique: true)
  end
end
