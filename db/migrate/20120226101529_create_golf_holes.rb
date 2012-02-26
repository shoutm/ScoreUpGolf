class CreateGolfHoles < ActiveRecord::Migration
  def change
    create_table :golf_holes do |t|
      t.integer :golf_cource_id
      t.integer :hole_no
      t.integer :par
      t.integer :yard

      t.timestamps
    end
  end
end
