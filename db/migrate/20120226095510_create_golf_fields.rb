class CreateGolfFields < ActiveRecord::Migration
  def change
    create_table :golf_fields do |t|
      t.string :name
      t.integer :region

      t.timestamps
    end
  end
end
