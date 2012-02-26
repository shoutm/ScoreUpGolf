class CreateGreens < ActiveRecord::Migration
  def change
    create_table :greens do |t|
      t.string :name

      t.timestamps
    end
  end
end
